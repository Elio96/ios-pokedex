//
//  ItemRespCoreData.swift
//  Pokedex
//
//  Created by Eliano Corallo on 15/10/22.
//

import Foundation

class ItemRespCoreData: NSObject, NSCoding {
    
    var name: String?
    var url: String?
    
    enum Key: String {
        case name
        case url
    }
    
    init(name: String?, url: String?) {
        self.name = name
        self.url = url
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: Key.name.rawValue)
        coder.encode(url, forKey: Key.url.rawValue)
    }
    
    required convenience init?(coder: NSCoder) {
        let name = coder.decodeObject(of: NSString.self, forKey: Key.name.rawValue) as? String
        let url = coder.decodeObject(of: NSString.self, forKey: Key.url.rawValue) as? String
        self.init(name: name, url: url)
    }
    
}
