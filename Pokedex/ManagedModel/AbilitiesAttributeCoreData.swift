//
//  AbilitiesAttributeCoreData.swift
//  Pokedex
//
//  Created by Eliano Corallo on 15/10/22.
//

import Foundation

public class AbilitiesAttributeCoreData: NSObject, NSCoding {
    
    var abilities: [AbilityAttributeCoreData]?
    
    enum Key: String {
        case abilities
    }
    
    init(abilities: [AbilityAttributeCoreData]?) {
        self.abilities = abilities
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(abilities, forKey: Key.abilities.rawValue)
    }
    
    public required convenience init?(coder: NSCoder) {
        let abilities = coder.decodeObject(forKey: Key.abilities.rawValue) as? [AbilityAttributeCoreData]
        self.init(abilities: abilities)
    }
    
}
