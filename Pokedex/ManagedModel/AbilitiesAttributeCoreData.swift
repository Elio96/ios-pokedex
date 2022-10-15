//
//  AbilitiesAttributeCoreData.swift
//  Pokedex
//
//  Created by Eliano Corallo on 15/10/22.
//

import Foundation

public class PokemonAttributeCoreData: NSObject, NSCoding {
    
    var attributes: [AttributeCoreData]?
    
    enum Key: String {
        case attributes
    }
    
    init(attributes: [AttributeCoreData]?) {
        self.attributes = attributes
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(attributes, forKey: Key.attributes.rawValue)
    }
    
    public required convenience init?(coder: NSCoder) {
        let attributes = coder.decodeObject(forKey: Key.attributes.rawValue) as? [AttributeCoreData]
        self.init(attributes: attributes)
    }
    
}
