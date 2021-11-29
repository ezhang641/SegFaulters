//
//  DetailedView.swift
//  ReviewU
//
//  Created by Ryan Toth on 10/31/21.
//

import Foundation
import UIKit
import SwiftUI

final class RecentSearches: UITableViewController {

//    var tabbar : TabBarController {
//              tabBarController as! TabBarController
//        }

    lazy var tabbar = tabBarController as! TabBarController
    var nameObj: [String:String] = [String:String]()
    var names:[String] = []
    //@State var searches = tabbar.recentSearches



    //Load view
    override func viewDidLoad() {
        super.viewDidLoad()
//        var tabbar = tabBarController as! TabBarController
        //tabbar = tabBarController as! TabBarController
        //print(tabbar.recentSearches)
        //print("here")


        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
       // tabbar = tabBarController as! TabBarController
        tableView.reloadData()
//        for prod in tabbar.recentSearches{
//            print(prod.name)
//        }
        print(tabbar.recentSearches)

        //searches.text = String(describing: tabbar.recentSearches)

    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabbar.recentSearches.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? TableCell else {
            fatalError("No reusable cell!")
        }
        let product = tabbar.recentSearches[indexPath.row]
        print("PRODUCT:")
        print(product.name!)
        print(product)
        
        names.append(product.name!)
        nameObj[product.name!] = product.asin
        cell.testLabel.text = product.name!

        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      guard
        segue.identifier == "showDetailedViewSegue",
        let indexPath = tableView.indexPathForSelectedRow,
        let detailViewController = segue.destination as? SummaryView
        else {
          return
      }

        let asin: String
        asin = nameObj[names[indexPath.row]]!

        print("IN HERE")
        let product = ProductStore.shared.products[indexPath.row]
        let tabbar = tabBarController as! TabBarController
        tabbar.recentSearches.insert(product, at: 0)
        //tabbar.recentSearches.insert(product.name!, at: 0)

        detailViewController.asin = asin
        nameObj.removeAll()
        names.removeAll()
    }
//
    
    
    
    
    

    
//    @IBOutlet weak var searches: UILabel!
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let tabbar = tabBarController as! TabBarController
//        print(tabbar.recentSearches)
//        searches.text = String(describing: tabbar.recentSearches)
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        let tabbar = tabBarController as! TabBarController
//        print(tabbar.recentSearches)
//        searches.text = String(describing: tabbar.recentSearches)
//    }
}

