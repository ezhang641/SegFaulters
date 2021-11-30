//
//  ContentView.swift
//  ReviewUSwiftUI
//
//  Created by Ryan Toth on 11/30/21.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection = 1
    init() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)], for: .selected)
    }
    var body: some View {
        Text("ReviewU Application")
            .font(.title2).bold()
            .frame(maxWidth: .infinity, maxHeight: 50)
            .foregroundColor(.white)
            .background(Color(UIColor(red: 168/255, green: 123/255, blue: 201/255, alpha: 1)))
        TabView(selection: $tabSelection) {
            NavigationView {
                Search()
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
            }
            .tabItem { Text("Search").padding(.trailing, 30) }.tag(1)
            NavigationView {
                Recent()
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
            }
            .tabItem { Text("Recent") }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Requests())
    }
}
