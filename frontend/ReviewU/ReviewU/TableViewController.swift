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
    
    
//    func updateSearchResults(for searchController: UISearchController) {
//        filteredTableData.removeAll(keepingCapacity: false)
//
//        filteredTableData = tableData.filter { (item: Item) -> Bool in
//
//            return (item.name?.lowercased().contains(searchController.searchBar.text!.lowercased()))!
//        }
//
//        self.tableView.reloadData()
//    }
    
    
 
 
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
        print(searchBar.text!)
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
        print("Table View")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? TableCell else {
            fatalError("No reusable cell!")
        }
        let product = ProductStore.shared.products[indexPath.row]
        print(product.name!)
        names.append(product.name!)
        nameObj[product.name!] = product.asin
        cell.testLabel.text = product.name
        // print(tableData[indexPath.row])
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      guard
        segue.identifier == "showDetailedViewSegue",
        let indexPath = tableView.indexPathForSelectedRow,
        let detailViewController = segue.destination as? DetailedView
        else {
          return
      }

      //let candy: Candy
       // let item: Item
        let asin: String
        asin = nameObj[names[indexPath.row]]!
        
      //detailViewController.candy = candy
        detailViewController.asin = asin
    }
    
}
