//
//  TableViewController.swift
//  IOSAddSearchTableViewTutorial
//
//  Created by Arthur Knopper on 13/12/2018.
//  Copyright © 2018 Arthur Knopper. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchResultsUpdating {
    //let tableData = ["One", "Two", "Three","Twenty-One"]
    var tableData: [Item] = []
    var filteredTableData: [Item] = []
    //var filteredTableData = [String]()
    var resultSearchController = UISearchController()
 
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)
        
        filteredTableData = tableData.filter { (item: Item) -> Bool in
          
            return (item.name?.contains(searchController.searchBar.text!))!
        }
        
        self.tableView.reloadData()
    }
 
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableData = Item.items()

        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            //controller.dimsBackgroundDuringPresentation = false
            //print("here")
            controller.obscuresBackgroundDuringPresentation = false;
            controller.searchBar.sizeToFit()
            
            tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        // Reload the table
        tableView.reloadData()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        if  (resultSearchController.isActive) {
            return filteredTableData.count
        } else {
            return tableData.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if (resultSearchController.isActive) {
            cell.textLabel?.text = filteredTableData[indexPath.row].name
            //print(indexPath.row)
            return cell
        }
        else {
            cell.textLabel?.text = tableData[indexPath.row].name
            print(tableData[indexPath.row])
            return cell
        }
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
        let item: Item
      if(resultSearchController.isActive){
          item = filteredTableData[indexPath.row]
        //candy = filteredCandies[indexPath.row]
      } else {
          item = tableData[indexPath.row]
        //candy = candies[indexPath.row]
      }
      //detailViewController.candy = candy
        detailViewController.item = item
    }
    
}
