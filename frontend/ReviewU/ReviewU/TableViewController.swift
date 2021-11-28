//
//  TableViewController.swift
//  ReviewU
//
//  Created by Ryan Toth on 10/31/21.
//

import Foundation
import UIKit

class TableViewController: UITableViewController, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    

    var names:[String] = []
    var nameObj: [String:String] = [String:String]()
    @IBOutlet weak var searchInput: UISearchBar!
    
    
 
 
    override func viewDidLoad() {
        super.viewDidLoad()
        searchInput.delegate = self
        searchInput.showsScopeBar = true
//        tableData = Item.items()

//        resultSearchController = ({
//            let controller = UISearchController(searchResultsController: nil)
//            controller.searchResultsUpdater = self
//            controller.obscuresBackgroundDuringPresentation = false;
//            controller.searchBar.sizeToFit()
//
//            tableView.tableHeaderView = controller.searchBar
//
//            return controller

    }
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar)
    {
        //let recentSearches = RecentSearches()
        
        //TabBarController.recentSearches.searches.append(searchBar.text!)
        //print(recentSearches.searches)
        
       // let tabbar = tabBarController as! TabBarController

        //tabbar.recentSearches.insert(searchBar.text!, at: 0)
        
        
        
        ProductStore.shared.getNames({ success in
            DispatchQueue.main.async {
                if success {
                    self.tableView.reloadData()
                }
            }
        }, query: searchBar.text!)
        
        // self.tableView.reloadData()
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductStore.shared.products.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? TableCell else {
            fatalError("No reusable cell!")
        }
        let product = ProductStore.shared.products[indexPath.row]
        
        names.append(product.name!)
        nameObj[product.name!] = product.asin
        cell.testLabel.text = product.name
        
        //TODO: get rid of this once figure out how to get prepare() function called
        
        let tabbar = tabBarController as! TabBarController
        tabbar.recentSearches.insert(product, at: 0)

        return cell
        
    }
    
    
    //NEED to connect with backend to test this. This function isn't being called at all right now, and I think it's because the productStore doesn't work properly when just dummy data. recentSearches list is empty because this isnt being called.
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
    
}
