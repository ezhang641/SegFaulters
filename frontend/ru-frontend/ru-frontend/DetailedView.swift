//
//  DetailedView.swift
//  ru-frontend
//
//  Created by Spencer Semple on 10/29/21.
//  Copyright © 2021 Arthur Knopper. All rights reserved.
//

import UIKit

final class DetailedView: UIViewController {
//  @IBOutlet weak var detailDescriptionLabel: UILabel!
//  @IBOutlet weak var candyImageView: UIImageView!
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        //print("here")
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var sentiment: UILabel!
    @IBOutlet weak var review1: UILabel!
    @IBOutlet weak var review2: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var sentimentLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    
//    var num: String? {
//        didSet {
//            configureView()
//        }
//    }
   // var num: String = ""
    
      var item: Item? {
        didSet {
          configureView()
        }
      }
   
    func configureView() {
      if let item = item,
         let itemName = itemName,
         let sentiment = sentiment,
         let review1 = review1,
         let review2 = review2,
         let summary = summary,
         let sentimentLabel = sentimentLabel,
         let reviewsLabel = reviewsLabel,
         let summaryLabel = summaryLabel{
          itemName.text = item.name
          sentiment.text = item.sentiment
          review1.text = item.review1
          review2.text = item.review2
          summary.text = item.summary
          sentimentLabel.text = "Sentiment:"
          reviewsLabel.text = "Popular reviews:"
          summaryLabel.text = "Summary:"
        }
        
    }
    

}
