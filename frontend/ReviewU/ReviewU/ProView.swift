//
//  ProView.swift
//  ReviewU
//
//  Created by Spencer Semple on 11/22/21.
//

import Foundation
import UIKit

final class ProView: UIViewController {
//  @IBOutlet weak var detailDescriptionLabel: UILabel!
//  @IBOutlet weak var candyImageView: UIImageView!
    var asin = ""
    
    //@IBOutlet weak var productName: UILabel!
    
    //sentiment
    
    @IBOutlet weak var productName: UILabel!
    //@IBOutlet weak var sentiment: UILabel!
    //summary
    
    @IBOutlet weak var sentiment: UILabel!
    //@IBOutlet weak var summary: UILabel!
    //review1
    @IBOutlet weak var pros: UILabel!
    
    @IBOutlet weak var summary: UILabel!
    //@IBOutlet weak var productImg: UIImageView!
    // @IBOutlet weak var review1: UILabel!
    //review2
    @IBOutlet weak var productImg: UIImageView!
    
   // @IBOutlet weak var review2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabbar = tabBarController as! TabView
        asin = tabbar.asin
        self.productName.text = tabbar.productName
        self.sentiment.text = tabbar.sentiment
        self.pros.text = tabbar.pros.first
        
//        let sentiment = self.sentiment
//        let review1 = self.review1
//        let review2 = self.review2
//        let summary = self.summary
//        let sentimentLabel = self.sentimentLabel
//        let reviewsLabel = self.reviewsLabel
//        let summaryLabel = self.summaryLabel
//        if Float(jsonObj["sentiment"]!)! > 0.0 {
//                sentiment!.text = "Positive"
//        }
//        else {
//                sentiment!.text = "Negative"
//        }
//        review1!.text = jsonObj["review1"]
//        review2!.text = jsonObj["review2"]
//        summary!.text = jsonObj["summary"]
//        sentimentLabel!.text = "Sentiment:"
//        reviewsLabel!.text = "Popular reviews:"
        //summaryLabel!.text = "Summary:"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let tabbar = tabBarController as! TabView
        asin = tabbar.asin
        self.productName.text = tabbar.productName
        self.sentiment.text = tabbar.sentiment
        self.pros.text = tabbar.pros.first

    }
    
    
    
    
//    }
   // var num: String = ""
    
//      var item: Item? {
//        didSet {
//          configureView()
//        }
//      }
    
   
//    func configureView() {
//      if let item = item,
//         let itemName = itemName,
//         let sentiment = sentiment,
//         let review1 = review1,
//         let review2 = review2,
//         let summary = summary,
//         let sentimentLabel = sentimentLabel,
//         let reviewsLabel = reviewsLabel,
//         let summaryLabel = summaryLabel{
//          itemName.text = item.name
//          sentiment.text = item.sentiment
//          review1.text = item.review1
//          review2.text = item.review2
//          summary.text = item.summary
//          sentimentLabel.text = "Sentiment:"
//          reviewsLabel.text = "Popular reviews:"
//          summaryLabel.text = "Summary:"
//        }
//
//    }
    

}

