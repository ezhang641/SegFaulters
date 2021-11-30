//
//  ProductStore.swift
//  ReviewU
//
//  Created by Ryan Toth on 10/31/21.
//

import Foundation
final class ProductStore: ObservableObject {
    static let shared = ProductStore()
    private init() {}
    
    @Published private(set) var products = [Product]()
    
    func getNames(_ completion: ((Bool) -> ())?, query:String) {
            
            guard let apiUrl = URL(string: "http://127.0.0.1:5000/amazon/getnames") else {
                print("getChatts: Bad URL")
                return
            }

            var request = URLRequest(url: apiUrl)
            request.httpMethod = "POST"
            print(query)

            request.httpBody = try? JSONSerialization.data(withJSONObject: ["name" : query])
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            URLSession.shared.dataTask(with: request) { data, response, error in
                var success = false
                defer { completion?(success)}
                guard let data = data, error == nil else {
//                    //ADDED FOR TESTING
//                    var product = Product()
//                    product.name = "test"
//                    product.asin = "12345"
//                    self.products.append(product)
//                    var product2 = Product()
//                    product2.name = "test2"
//                    product2.asin = "6789"
//                    self.products.append(product2)
//                    print(self.products)
//                    success = true
//                    //END ADDED FOR TESTING
                    print("getNames: NETWORKING ERROR")

                    return
                }
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("getNames: HTTP STATUS: \(httpStatus.statusCode)")
                    return
                }

                guard let jsonObj = try? JSONSerialization.jsonObject(with: data) as? [String:String] else {
                    print("getNames: failed JSON deserialization")
                    return
                }
                DispatchQueue.main.sync{
                    self.products = [Product]()
                    for (key, value) in jsonObj {
                        self.products.append(Product(name: key,
                                                     asin: value))
                    }
                }
                success = true

            }.resume()
        


        
        
        }
    func getContent(_ completion: ((Bool) -> ())?, asin:String) {
        var success = false
        self.products.removeAll()
            guard let apiUrl = URL(string: "http://127.0.0.1:5000/amazon/information") else {
                print("getContent: Bad URL")
                return
            }
            
            var request = URLRequest(url: apiUrl)
            request.httpMethod = "POST"
            request.httpBody = try? JSONSerialization.data(withJSONObject: ["product_asin" : asin], options: [])
            print(asin)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let sessionConfig = URLSessionConfiguration.default
            sessionConfig.timeoutIntervalForRequest = 30.0
            sessionConfig.timeoutIntervalForResource = 60.0
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                defer { completion?(success)}
                guard let data = data, error == nil else {
                    print("getContent: NETWORKING ERROR")
                    return
                }
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print(error)
                    print("getContent: HTTP STATUS: \(httpStatus.statusCode)")
                    return
                }
                
                guard var jsonObj = try? JSONSerialization.jsonObject(with: data) as? [String:String] else {
                    print("getContent: failed JSON deserialization")
                    return
                }
                DispatchQueue.main.sync{
                    self.products = [Product]()
                    var product = Product()
                    for (key, value) in jsonObj {
                        
                        if key == "name" {
                            product.name = value
                        }
//                        if key == "review1" {
//                            product.review1 = value
//                        }
//                        if key == "review2" {
//                            product.review2 = value
//                        }
                        if key == "sentiment" {
                            product.sentiment = value
                        }
                        if key == "summary" {
                            product.summary = value
                        }
                        if key == "image" {
                            product.image = value
                        }
                        if key == "pros" {
                            let components = value.components(separatedBy: "*")
                            product.pros = components
                        }
                        if key == "cons" {
                            let components = value.components(separatedBy: "*")
                            product.cons = components
                        }
                    }
                    self.products.append(product)
                }
                success = true
                jsonObj = [:]
                

            }.resume()
        }
}
