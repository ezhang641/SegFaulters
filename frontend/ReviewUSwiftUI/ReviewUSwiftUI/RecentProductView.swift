//
//  ProductView.swift
//  ReviewUSwiftUI
//
//  Created by Ryan Toth on 11/30/21.
//

import SwiftUI

struct RecentProductView: View {
    @State private var tabSelection = 1
    @Binding var asin : String
    @EnvironmentObject var requests: Requests
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
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
                        .padding(.leading, 15)
                    if (requests.image != "") {
                        let url = URL(string: requests.image)!
                        if let data = try? Data(contentsOf: url) {
                            Image(uiImage: UIImage(data: data)!)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150, alignment: .trailing)
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
            requests.getProductInfo(asin: self.asin)
        }.onDisappear {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct RecentProductView_Previews: PreviewProvider {
    @State static var asin = ""
    static var previews: some View {
        RecentProductView(asin: $asin)
    }
}
