//
//  Requests.swift
//  ReviewUSwiftUI
//
//  Created by Ryan Toth on 11/30/21.
//

import SwiftUI

import Foundation

struct search_data: Decodable {
    var productNames : [String]
    var productAsin : [String]
}

struct product_data: Decodable {
    var cons : String
    var image : String
    var name : String
    var pros : String
    var summary : String
    var sentiment : String
}

class Requests: ObservableObject {
    @Published var productNames : [String] = ["", "", ""]
    @Published var productAsin : [String] = ["", "", ""]
    @Published var cons : [String] = []
    @Published var image : String = ""
    @Published var name : String = ""
    @Published var pros : [String] = []
    @Published var summary : String = ""
    @Published var sentiment : String = ""
    @Published var searchLoading = false
    @Published var productLoading = false
    @Published var recents : [[String]] = []
    @Published var reviewProductAsin : String = ""
    @Published var isReview = false

    func getResults(query: String) {
        guard let url = URL(string: "https://3.138.111.153/amazon/getnames") else { fatalError("Missing URL") }

        var urlRequest = URLRequest(url: url)
        let json: [String: Any] = ["name": query]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        urlRequest.httpBody = jsonData
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let responseData = try JSONDecoder().decode(search_data.self, from: data)
                        self.productNames = responseData.productNames
                        self.productAsin = responseData.productAsin
                        self.searchLoading = false
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func getProductInfo(asin: String) {
        guard let url = URL(string: "https://3.138.111.153/amazon/information") else { fatalError("Missing URL") }

        var urlRequest = URLRequest(url: url)
        let json: [String: Any] = ["product_asin": asin]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        urlRequest.httpBody = jsonData
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let responseData = try JSONDecoder().decode(product_data.self, from: data)
                        let arrCons = responseData.cons.components(separatedBy: "*")
                        self.cons = arrCons
                        self.image = responseData.image
                        self.name = responseData.name
                        let arrPros = responseData.pros.components(separatedBy: "*")
                        self.pros = arrPros
                        self.summary = responseData.summary
                        self.sentiment = responseData.sentiment
                        self.productLoading = false
                        let recentArr = [responseData.name, asin]
                        self.recents.append(recentArr)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
}
