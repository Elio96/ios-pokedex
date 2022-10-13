//
//  Box.swift
//  Pokedex
//
//  Created by Eliano Corallo on 13/10/22.
//

import Foundation

final class Box<T> {
    
    typealias Listener = (T) -> Void
    var listeners: [Listener] = []
    
    var value: T {
        didSet {
            listeners.forEach({$0(value)})
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: @escaping Listener) {
        self.listeners.append(listener)
        listener(value)
    }
}
