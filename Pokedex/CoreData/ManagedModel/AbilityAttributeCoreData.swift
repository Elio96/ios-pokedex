//
//  AbilityAttributeCoreData.swift
//  Pokedex
//
//  Created by Eliano Corallo on 15/10/22.
//

import Foundation

class AttributeCoreData: NSObject, NSCoding {
    
    var name: String?
    var url: String?
    var baseStat: Int?
    
    enum Key: String {
        case name
        case url
        case baseStat
    }
    
    init(name: String?, url: String?, baseStat: Int? = nil) {
        self.name = name
        self.url = url
        self.baseStat = baseStat
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: Key.name.rawValue)
        coder.encode(url, forKey: Key.url.rawValue)
        coder.encode(baseStat, forKey: Key.baseStat.rawValue)
    }
    
    required convenience init?(coder: NSCoder) {
        let name = coder.decodeObject(of: NSString.self, forKey: Key.name.rawValue) as? String
        let url = coder.decodeObject(of: NSString.self, forKey: Key.url.rawValue) as? String
        let baseStat = coder.decodeObject(of: NSNumber.self, forKey: Key.baseStat.rawValue) as? Int
        self.init(name: name, url: url, baseStat: baseStat)
    }
    
}
