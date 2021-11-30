//
//  ProView.swift
//  ReviewU
//
//  Created by Spencer Semple on 11/22/21.
//

import Foundation
import UIKit
import SwiftUI

final class TabView: UITabBarController {
    var productName: String!
    var sentiment: String!
    var pros: [String]!
    var cons: [String]!
    var summary: String!
    var productImg: String!
    
    let emotionMap: [String: String] = [
        "Happy": "😁",
        "Love": "😱",
        "Frustrated": "😠",
        "Sad": "😢",
        "Bored": "😒",
        "Neutral": "😳",
    ]
    
    var asin = ""
    override func viewDidLoad() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        let summary = SummaryView()
        let pros = ProView()
        let cons = ConView()

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        ProductStore.shared.getContent({ success in
            DispatchQueue.main.async {
                if success {
                    print("HERE")
                    let product = ProductStore.shared.products[0]
                    self.productName = product.name
                    self.sentiment = self.emotionMap[product.sentiment!]
                    self.summary = product.summary
                    self.productImg = product.image!
                    self.pros = product.pros
                    self.cons = product.cons
                    
                    summary.viewDidLoad()
                    
                    pros.viewDidLoad()
                    
                    cons.viewDidLoad()
                    
                    self.dismiss(animated: false, completion: nil)
                    super.viewDidLoad()
                
                    self.setViewControllers([summary, pros, cons], animated: true)
//                    self.reloadInputViews()
                }
            }
        }, asin: asin)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        ProductStore.shared.getContent({ success in
            DispatchQueue.main.async {
                if success {
                    print("HERE")
                    let product = ProductStore.shared.products[0]
                    self.productName = product.name
                    self.sentiment = self.emotionMap[product.sentiment!]
                    self.summary = product.summary
                    self.productImg = product.image!
                    self.pros = product.pros
                    self.cons = product.cons
                    self.dismiss(animated: false, completion: nil)
//                    super.viewDidLoad()
                }
            }
        }, asin: asin)

    }

}

