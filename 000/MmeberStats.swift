import Foundation
import UIKit

//struct ConfigCardPaymentDTO: Codable {
//    var configID: Int
//    var configItems: [ConfigItem]
//    var bankList: String?
//
//
//}
//enum CodingKeys: String, CodingKey {
//    case configID
//    case configItems, bankList
//}
//
//struct ConfigItem: Codable {
//    var a : String
//    var b, c, d: String?
//    var e, f: String?
//    var g: Int
//    var h: String?
//    var i: Bool
//}

///
struct ConfigCardPaymentDTO: Codable {
    let configId: Int
    let configItems: [ConfigItem]
}

struct ConfigItem: Codable {
    let a: String
    let b: String?
    let c: String?
    let d: String?
    let e: String?
    let f: String?
    let g: Int
    let h: String?
    let i: Bool
}

struct BankListDTO: Codable {
    let bankList: [String]
}

///


extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file) from bundle.")
        }
        
        return loadedData
    }
}


/*
 
 ["ConfigCardPaymentDTO","{\"configId\":1,\"configItems\":[{\"a\":\"2E4U\\u003d1VS4CS4\",\"b\":\"\",\"c\":\"\",\"d\":\"\",\"e\":\"f1d8\",\"f\":\"\",\"g\":3,\"h\":\"\",\"i\":true},{\"a\":\"9CVA\\u003dF1CW\",\"b\":\"\",\"c\":\"\",\"d\":\"\",\"e\":\"f2b4\",\"f\":\"\",\"g\":2,\"h\":\"\",\"i\":true},{\"a\":\"3CA194\\u003d1NE1I\",\"b\":\"\",\"c\":\"\",\"d\":\"\",\"e\":\"f2b9\",\"f\":\"\",\"g\":9,\"h\":\"\",\"i\":true},{\"a\":\"N2H\\u003dRT21VQ\",\"b\":\"\",\"c\":\"\",\"d\":\"\",\"e\":\"f1ca\",\"f\":\"\",\"g\":10,\"h\":\"\",\"i\":true},{\"a\":\"O1C4\\u003d2U\\u003dO1C4\",\"b\":\"\",\"c\":\"\",\"d\":\"\",\"e\":\"f2b5\",\"f\":\"\",\"g\":0,\"h\":\"\",\"i\":true},{\"a\":\"3CA194\\u003dN2H\",\"b\":\"\",\"c\":\"\",\"d\":\"\",\"e\":\"f2b3\",\"f\":\"\",\"g\":1,\"h\":\"\",\"i\":true},{\"a\":\"RT21VQ\\u003d2U\\u003dRT21VQ\",\"b\":\"\",\"c\":\"\",\"d\":\"\",\"e\":\"f1bc\",\"f\":\"\",\"g\":7,\"h\":\"\",\"i\":true},{\"a\":\"ACV1M4\\u003dF21\",\"b\":\"\",\"c\":\"\",\"d\":\"\",\"e\":\"f219\",\"f\":\"\",\"g\":11,\"h\":\"\",\"i\":true},{\"a\":\"FK2U\\u003dV12\",\"b\":\"\",\"c\":\"\",\"d\":\"\",\"e\":\"f1c4\",\"f\":\"\",\"g\":8,\"h\":\"\",\"i\":true}]}","BankListDTO","{\"bankList\":[]}"]
 
 
 /*
  do {
      if let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [Any] {
          for item in jsonArray {
              if let string = item as? String {
                  print("String: \(string)")
              } else if let array = item as? [String] {
                  print("Array: \(array)")
              } else if let dictionary = item as? [String: Any] {
                  print("Dictionary: \(dictionary)")
              }
          }
      }
  } catch {
      print("Error with JSONSerialization: \(error)")
  }
  
  
  
  do {
      if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
         let employees = jsonObject["employees"] as? [[String: Any]] {
          for employee in employees {
              let firstName = employee["firstName"] as? String
              let lastName = employee["lastName"] as? String
              
              print("First Name: \(firstName ?? "")")
              print("Last Name: \(lastName ?? "")")
          }
      }
  } catch {
      print("Error with JSONSerialization: \(error)")
  }
  */

 */
