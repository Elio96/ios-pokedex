//
//  Extension+String.swift
//  Pokedex
//
//  Created by Eliano Corallo on 14/10/22.
//

import Foundation

extension String {
    var withoutDash: String {
        let dash = replacingOccurrences(of: "-", with: " ").capitalized
        return dash
    }
}
