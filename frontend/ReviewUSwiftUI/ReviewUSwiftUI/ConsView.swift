//
//  ConsView.swift
//  ReviewUSwiftUI
//
//  Created by Ryan Toth on 11/30/21.
//

import SwiftUI

struct ConsView: View {
    @EnvironmentObject var requests: Requests
    var body: some View {
        VStack {
            Text("Cons:")
                .font(.system(size: 25)).bold()
            List {
                ForEach(requests.cons, id:\.self) {con in
                    Text(con)
                }
            }
            Spacer()
        }
    }
}

struct ConsView_Previews: PreviewProvider {
    static var previews: some View {
        ConsView()
    }
}
