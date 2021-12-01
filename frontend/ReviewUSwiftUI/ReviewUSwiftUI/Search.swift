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

/// TextField capable of making predictions based on provided predictable values
//struct PredictingTextField: View {
//
//    /// All possible predictable values. Can be only one.
//    @Binding var predictableValues: Array<String>
//
//    /// This returns the values that are being predicted based on the predictable values
//    @Binding var predictedValues: Array<String>
//
//    /// Current input of the user in the TextField. This is Binded as perhaps there is the urge to alter this during live time. E.g. when a predicted value was selected and the input should be cleared
//    @Binding var textFieldInput: String
//
//    /// The time interval between predictions based on current input. Default is 0.1 second. I would not recommend setting this to low as it can be CPU heavy.
//    @State var predictionInterval: Double?
//
//    /// Placeholder in empty TextField
//    @State var textFieldTitle: String?
//
//    @Binding private var isBeingEdited: Bool
//
//    init(predictableValues: Binding<Array<String>>, predictedValues: Binding<Array<String>>, textFieldInput: Binding<String>, textFieldTitle: String? = "", predictionInterval: Double? = 0.1, typing: Binding<Bool>){
//
//        self._predictableValues = predictableValues
//        self._predictedValues = predictedValues
//        self._textFieldInput = textFieldInput
//        self._isBeingEdited = typing
//
//        self.textFieldTitle = textFieldTitle
//        self.predictionInterval = predictionInterval
//    }
//
//    var body: some View {
//        TextField("Search Here...", text: self.$textFieldInput, onEditingChanged: { editing in self.realTimePrediction(status: editing)}, onCommit: { self.makePrediction()})
//    }
//
//    /// Schedules prediction based on interval and only a if input is being made
//    private func realTimePrediction(status: Bool) {
//        self.isBeingEdited = status
//        if status == true {
//            Timer.scheduledTimer(withTimeInterval: self.predictionInterval ?? 1, repeats: true) { timer in
//                self.makePrediction()
//
//                if self.isBeingEdited == false {
//                    timer.invalidate()
//                }
//            }
//        }
//    }
//
//    /// Capitalizes the first letter of a String
//    private func capitalizeFirstLetter(smallString: String) -> String {
//        return smallString.prefix(1).capitalized + smallString.dropFirst()
//    }
//
//    /// Makes prediciton based on current input
//    private func makePrediction() {
//        self.predictedValues = []
//        if !self.textFieldInput.isEmpty{
//            for value in self.predictableValues {
//                if self.textFieldInput.split(separator: " ").count > 1 {
//                    self.makeMultiPrediction(value: value)
//                }else {
//                    if value.contains(self.textFieldInput) || value.contains(self.capitalizeFirstLetter(smallString: self.textFieldInput)){
//                        if !self.predictedValues.contains(String(value)) {
//                            self.predictedValues.append(String(value))
//                        }
//                    }
//                }
//            }
//        }
//        print(self.predictedValues)
//    }
//
//    /// Makes predictions if the input String is splittable
//    private func makeMultiPrediction(value: String) {
//        self.predictedValues.append(self.textFieldInput)
//        for subString in self.textFieldInput.split(separator: " ") {
//            if value.contains(String(subString)) || value.contains(self.capitalizeFirstLetter(smallString: String(subString))){
//                if !self.predictedValues.contains(value) {
//                    self.predictedValues.append(value)
//                }
//            }
//        }
//    }
//}

struct Search: View {
    @State var query: String = ""
    @EnvironmentObject var requests: Requests
    @State var isLoading = false
    @State var selectedIndex: Int?
    @State var num0 = 0
    @State var num1 = 1
    @State var num2 = 2
    @State var typing = false
    
    @State var predictableValues: Array<String> = ["Nintendo Switch", "Laptop", "Kindle", "Airpods", "iPhone", "Lego", "Apple Watch", "Apple iPhone", "Basketball Shoes", "Basketball"]
    @State var predictedValue: Array<String> = []
    
    /// Schedules prediction based on interval and only a if input is being made
    private func realTimePrediction(status: Bool) {
//        self.typing = true
        if status == true {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                self.makePrediction()

                if self.typing == false {
                    timer.invalidate()
                }
            }
        }
    }

    /// Capitalizes the first letter of a String
    private func capitalizeFirstLetter(smallString: String) -> String {
        return smallString.prefix(1).capitalized + smallString.dropFirst()
    }

    /// Makes prediciton based on current input
    private func makePrediction() {
        self.predictedValue = []
        if !self.query.isEmpty{
            for value in self.predictableValues {
                if self.query.split(separator: " ").count > 1 {
                    self.makeMultiPrediction(value: value)
                }else {
                    if value.contains(self.query) || value.contains(self.capitalizeFirstLetter(smallString: self.query)){
                        if !self.predictedValue.contains(String(value)) {
                            self.predictedValue.append(String(value))
                        }
                    }
                }
            }
        }
        print(self.predictedValue)
    }

    /// Makes predictions if the input String is splittable
    private func makeMultiPrediction(value: String) {
        self.predictedValue.append(self.query)
        for subString in self.query.split(separator: " ") {
            if value.contains(String(subString)) || value.contains(self.capitalizeFirstLetter(smallString: String(subString))){
                if !self.predictedValue.contains(value) {
                    self.predictedValue.append(value)
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search Here...", text: self.$query, onEditingChanged: { editing in
                    self.typing = editing
                    self.realTimePrediction(status: editing)
                }, onCommit: {
                    self.makePrediction()
                })
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                Button {
                    requests.searchLoading = true
                    requests.getResults(query: query)
                    self.typing = false
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                } label: {
                    Text("Search")
                }
            }.padding(.trailing, 15).padding(.leading, 15)
            if (self.typing) {
                List() {
                    ForEach(self.predictedValue, id: \.self){ value in
                        Text(value).onTapGesture {
                            self.query = value
                            self.typing = false
                        }
                    }
                }
            }
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
        }.onAppear {
            requests.isReview = false
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
            .environmentObject(Requests())
    }
}
