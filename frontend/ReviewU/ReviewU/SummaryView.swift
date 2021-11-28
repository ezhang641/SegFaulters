//
//  DetailedView.swift
//  ReviewU
//
//  Created by Ryan Toth on 10/31/21.
//

import Foundation
import UIKit

final class SummaryView: UIViewController {
//  @IBOutlet weak var detailDescriptionLabel: UILabel!
//  @IBOutlet weak var candyImageView: UIImageView!
    var asin = ""
    
    @IBOutlet weak var productName: UILabel!
    
    //sentiment
    
    @IBOutlet weak var sentiment: UILabel!
    //summary
    
    @IBOutlet weak var summary: UILabel!
    //review1
    
    @IBOutlet weak var productImg: UIImageView!
    // @IBOutlet weak var review1: UILabel!
    //review2
   
   // @IBOutlet weak var review2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductStore.shared.getContent({ success in
            DispatchQueue.main.async {
                if success {
                    let product = ProductStore.shared.products[0]
                    self.productName.text = product.name
                    if Double(product.sentiment!)! > 0.0 {
                        self.sentiment.text = "Positive"
                    }
                    else {
                        self.sentiment.text = "Negative"
                    }
//                    self.sentiment.text = product.sentiment
                    self.summary.text = product.summary
                    //self.review1.text = product.review1
                    //self.review2.text = product.review2
                    self.productImg = product.image
                }
            }
        }, asin: asin)
        
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
//        summaryLabel!.text = "Summary:"
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
