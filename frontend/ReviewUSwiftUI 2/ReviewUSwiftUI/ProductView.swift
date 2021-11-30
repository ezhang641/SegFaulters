//
//  ProductView.swift
//  ReviewUSwiftUI
//
//  Created by Ryan Toth on 11/30/21.
//

import SwiftUI

struct ProductView: View {
    @State private var tabSelection = 1
    @Binding var selectedIndex : Int
    @EnvironmentObject var requests: Requests
    let emotionMap: [String: String] = [
        "Happy": "😁",
        "Love": "😱",
        "Frustrated": "😠",
        "Sad": "😢",
        "Bored": "😒",
        "Neutral": "😳",
    ]
    
    var body: some View {
        VStack {
            if (requests.productLoading) {
                ActivityIndicator(isAnimating: .constant(true), style: .large)
            }
            else {
                HStack {
                    Text(requests.name)
                        .font(.system(size: 25)).bold()
                    if (requests.image != "") {
                        let url = URL(string: requests.image)!
                        if let data = try? Data(contentsOf: url) {
                            Image(uiImage: UIImage(data: data)!)
                                .resizable()
                                .frame(width: 150, height: 150, alignment: .trailing)
                                .scaledToFit()
                            }
                    }
                }
                HStack {
                    Text("Sentiment")
                        .font(.system(size: 25)).bold()
                    if (requests.sentiment != "") {
                        Text(emotionMap[requests.sentiment]!)
                            .font(.system(size: 35))
                    }
                }
                TabView(selection: $tabSelection) {
                    NavigationView {
                        SummaryView()
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                    }
                    .tabItem { Text("Summary") }.tag(1)
                    NavigationView {
                        ProsView()
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                    }
                    .tabItem { Text("Pros") }.tag(2)
                    NavigationView {
                        ConsView()
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                    }
                    .tabItem { Text("Cons") }.tag(3)
                }
                Spacer()
            }
        }.onAppear {
            requests.productLoading = true
            requests.getProductInfo(asin: requests.productAsin[self.selectedIndex])
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    @State static var selectedIndex = 0
    static var previews: some View {
        ProductView(selectedIndex: $selectedIndex)
    }
}
