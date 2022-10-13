//
//  ProgrammaticallyConstrained.swift
//  Pokedex
//
//  Created by Eliano Corallo on 12/10/22.
//

import UIKit

@propertyWrapper
struct ProgrammaticallyConstrained<T: UIView> {
    
    var wrappedValue: T

    init(wrappedValue: T) {
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        self.wrappedValue = wrappedValue
    }
}
