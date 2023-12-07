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
    let b: String
    let c: String
    let d: String
    let e: String
    let f: String
    let g: Int
    let h: String
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
