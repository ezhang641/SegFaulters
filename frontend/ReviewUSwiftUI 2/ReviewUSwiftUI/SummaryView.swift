//
//  SummaryView.swift
//  ReviewUSwiftUI
//
//  Created by Ryan Toth on 11/30/21.
//

import SwiftUI

struct SummaryView: View {
    @EnvironmentObject var requests: Requests
    var body: some View {
        VStack {
            Text("Summary:")
                .font(.system(size: 25)).bold()
            Text(requests.summary)
                .padding(15).font(.system(size: 15))
            Spacer()
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}
