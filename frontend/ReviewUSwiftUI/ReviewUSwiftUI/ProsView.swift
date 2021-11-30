//
//  ProsView.swift
//  ReviewUSwiftUI
//
//  Created by Ryan Toth on 11/30/21.
//

import SwiftUI

struct ProsView: View {
    @EnvironmentObject var requests: Requests
    var body: some View {
        VStack {
            Text("Pros:")
                .font(.system(size: 25)).bold()
            List {
                ForEach(requests.pros, id:\.self) {pro in
                    Text(pro)
                }
            }
            Spacer()
        }
    }
}

struct ProsView_Previews: PreviewProvider {
    static var previews: some View {
        ProsView()
    }
}
