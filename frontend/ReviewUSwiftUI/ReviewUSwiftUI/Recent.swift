//
//  Recent.swift
//  ReviewUSwiftUI
//
//  Created by Ryan Toth on 11/30/21.
//

import SwiftUI

struct Recent: View {
    @EnvironmentObject var requests: Requests
    @State var num0 = 0
    var body: some View {
        VStack {
//            Text("Recent Searches:")
//                .font(.system(size: 25)).bold()
//            List {
//                ForEach(requests.recents, id:\.self) {product in
//                    NavigationLink(destination: ProductView(selectedIndex: $num0)) {
//                        Text(product[0])
//                    }.onTapGesture {
//                        requests.productAsin = [product[1]]
//                    }
//                }
//            }
//            Spacer()
        }
    }
}

struct Recent_Previews: PreviewProvider {
    static var previews: some View {
        Recent()
    }
}
