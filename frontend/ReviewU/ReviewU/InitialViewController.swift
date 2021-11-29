//
//  PinkViewController.swift
//  ReviewU
//
//  Created by Spencer Semple on 11/28/21.
//

//import Foundation
//import UIKit
//
//
//
//final class InitialViewController: UIViewController, UITextFieldDelegate {
//    
//    @IBAction func searchButton(_ sender: Any) {
//        
//        
//        ProductStore.shared.getNames({ success in
//            DispatchQueue.main.async {
//                if success {
//                    self.tableView.reloadData()
//                }
//            }
//        }, query: textField.text!)
//    }
//    
//    
//   // @IBOutlet weak var searchButton: UIButton!
//    
//    var names:[String] = []
//    var nameObj: [String:String] = [String:String]()
//
//    
//    var suggestionsArray = [String]()
//    @IBOutlet weak var textField: UITextField!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        textField.delegate = self
////        suggestionsArray = getCSVData()
////        print(suggestionsArray[0])
//        var data = readDataFromCSV(fileName: "/words", fileType: "csv")
//        data = cleanRows(file: data!)
//        suggestionsArray = csv(data: data!)
//        print(suggestionsArray[1000])
//    }
//    
//    func cleanRows(file:String)->String{
//        var cleanFile = file
//        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
//        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
//        //        cleanFile = cleanFile.replacingOccurrences(of: ";;", with: "")
//        //        cleanFile = cleanFile.replacingOccurrences(of: ";\n", with: "")
//        return cleanFile
//    }
//    
//    func readDataFromCSV(fileName:String, fileType: String)-> String!{
//            guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
//                else {
//                    return nil
//            }
//            do {
//                var contents = try String(contentsOfFile: filepath, encoding: .utf8)
//                contents = cleanRows(file: contents)
//                return contents
//            } catch {
//                print("File Read Error for file \(filepath)")
//                return nil
//            }
//        }
//    
//    func csv(data: String) -> [String] {
//            var result = [String]()
//            let rows = data.components(separatedBy: "\n")
//            for row in rows {
//                result.append(row)
//            }
//            return result
//        }
//    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//            return !autoCompleteText( in : textField, using: string, suggestionsArray: suggestionsArray)
//    }
//    
//    func autoCompleteText( in textField: UITextField, using string: String, suggestionsArray: [String]) -> Bool {
//            if !string.isEmpty,
//                let selectedTextRange = textField.selectedTextRange,
//                selectedTextRange.end == textField.endOfDocument,
//                let prefixRange = textField.textRange(from: textField.beginningOfDocument, to: selectedTextRange.start),
//                let text = textField.text( in : prefixRange) {
//                let prefix = text + string
//                let matches = suggestionsArray.filter {
//                    $0.hasPrefix(prefix)
//                }
//                if (matches.count > 0) {
//                    textField.text = matches[0]
//                    if let start = textField.position(from: textField.beginningOfDocument, offset: prefix.count) {
//                        textField.selectedTextRange = textField.textRange(from: start, to: textField.endOfDocument)
//                        return true
//                    }
//                }
//            }
//            return false
//        }
//    
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//            textField.resignFirstResponder()
//            return true
//    }
//
//    
//    
//    
//    
//    
//    
//    
//}
