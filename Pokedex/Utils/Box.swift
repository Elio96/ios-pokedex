//
//  Box.swift
//  Pokedex
//
//  Created by Eliano Corallo on 13/10/22.
//

import Foundation

//is an object used to observe a value
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
    
    //trigger an event in the listener which call this function when the value change
    func bind(listener: @escaping Listener) {
        self.listeners.append(listener)
        listener(value)
    }
}
