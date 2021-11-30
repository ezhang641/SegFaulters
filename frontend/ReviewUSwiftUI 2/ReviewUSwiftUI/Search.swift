//
//  Search.swift
//  ReviewUSwiftUI
//
//  Created by Ryan Toth on 11/30/21.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct Search: View {
    @State var query: String = ""
    @EnvironmentObject var requests: Requests
    @State var isLoading = false
    @State var selectedIndex: Int?
    @State var num0 = 0
    @State var num1 = 1
    @State var num2 = 2
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search ...", text: $query)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                Button {
                    requests.searchLoading = true
                    requests.getResults(query: query)
                } label: {
                    Text("Search")
                }
            }.padding(.trailing, 15).padding(.leading, 15)
            if (requests.productNames[0] != "" && requests.searchLoading == false) {
                List {
                    NavigationLink(destination: ProductView(selectedIndex: $num0)) {
                        Text(requests.productNames[0])
                    }
                    NavigationLink(destination: ProductView(selectedIndex: $num1)) {
                        Text(requests.productNames[1])
                    }
                    NavigationLink(destination: ProductView(selectedIndex: $num2)) {
                        Text(requests.productNames[2])
                    }
                }
            }
            if (requests.searchLoading) {
                ActivityIndicator(isAnimating: .constant(true), style: .large)
            }
            Spacer()
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
            .environmentObject(Requests())
    }
}
