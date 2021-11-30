import Foundation
import UIKit

final class Loader: UIViewController {
    var productName: String!
    var sentiment: String!
    var pros: [String]!
    var cons: [String]!
    var summary: String!
    var productImg: UIImageView!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    let emotionMap: [String: String] = [
        "Happy": "😁",
        "Love": "😱",
        "Frustrated": "😠",
        "Sad": "😢",
        "Bored": "😒",
        "Neutral": "😳",
    ]
    
    var asin = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingIndicator.stopAnimating()
        ProductStore.shared.getContent({ success in
            DispatchQueue.main.async {
                self.loadingIndicator.startAnimating()
                if success {
                    print("HERE")
                    let product = ProductStore.shared.products[0]
                    self.productName = product.name
                    self.sentiment = self.emotionMap[product.sentiment!]
                    self.summary = product.summary
                    self.productImg = product.image
                    self.pros = product.pros
                    self.cons = product.cons
                    self.loadingIndicator.stopAnimating()
                }
            }
        }, asin: asin)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ProductStore.shared.getContent({ success in
            DispatchQueue.main.async {
                self.loadingIndicator.startAnimating()
                if success {
                    print("HERE")
                    let product = ProductStore.shared.products[0]
                    self.productName = product.name
                    self.sentiment = self.emotionMap[product.sentiment!]
                    self.summary = product.summary
                    self.productImg = product.image
                    self.pros = product.pros
                    self.cons = product.cons
                    self.loadingIndicator.stopAnimating()
                }
            }
        }, asin: asin)

    }
}
