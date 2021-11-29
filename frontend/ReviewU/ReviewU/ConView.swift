//
//  ConView.swift
//  ReviewU
//
//  Created by Spencer Semple on 11/22/21.
//

import Foundation
import UIKit

final class ConView: UIViewController, UITableViewDataSource, UITableViewDelegate {
//  @IBOutlet weak var detailDescriptionLabel: UILabel!
//  @IBOutlet weak var candyImageView: UIImageView!
    var asin = ""
    
   // @IBOutlet weak var productName: UILabel!
    
    //sentiment
    
    @IBOutlet weak var productName: UILabel!
    //@IBOutlet weak var sentiment: UILabel!
    //summary
    
    //@IBOutlet weak var summary: UILabel!
    //review1
    @IBOutlet weak var sentiment: UILabel!
    
    //@IBOutlet weak var productImg: UIImageView!
    // @IBOutlet weak var review1: UILabel!
    //review2
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var cons: UILabel!
    
    @IBOutlet weak var productImg: UIImageView!
    // @IBOutlet weak var review2: UILabel!
    //@IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabbar = tabBarController as! TabView
        asin = tabbar.asin
        self.productName.text = tabbar.productName
        self.sentiment.text = tabbar.sentiment
        //self.cons.text = tabbar.cons.first
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let tabbar = tabBarController as! TabView
        asin = tabbar.asin
        self.productName.text = tabbar.productName
        self.sentiment.text = tabbar.sentiment
        //self.cons.text = tabbar.cons.first

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tabbar = tabBarController as! TabView
        return tabbar.cons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? TableCell else {
            fatalError("No reusable cell!")
        }
        let tabbar = tabBarController as! TabView
        let con = tabbar.cons[indexPath.row]
        
        cell.testLabel.text = con

        return cell
    }
    
    
    

}


