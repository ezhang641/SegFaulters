//
//  Item.swift
//  ru-frontend
//
//  Created by Spencer Semple on 10/29/21.
//  Copyright © 2021 Arthur Knopper. All rights reserved.
//

import Foundation

struct Item: Decodable {
    var name: String?
    var sentiment: String?
    var summary: String?
    var review1: String?
    var review2: String?
}

//extension Item {
//  static func items() -> [Item] {
//      for(item in )
//  }
//}

extension Item {
  static func items() -> [Item] {
    guard
      let url = Bundle.main.url(forResource: "items", withExtension: "json"),
      let data = try? Data(contentsOf: url)
      else {
        return []
    }
    
    do {
      let decoder = JSONDecoder()
      return try decoder.decode([Item].self, from: data)
    } catch {
      return []
    }
  }
}
