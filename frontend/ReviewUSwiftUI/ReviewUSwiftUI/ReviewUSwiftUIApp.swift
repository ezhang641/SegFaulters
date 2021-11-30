//
//  ReviewUSwiftUIApp.swift
//  ReviewUSwiftUI
//
//  Created by Ryan Toth on 11/30/21.
//

import SwiftUI

@main
struct ReviewUSwiftUIApp: App {
    var requests = Requests()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(requests)
        }
    }
}
