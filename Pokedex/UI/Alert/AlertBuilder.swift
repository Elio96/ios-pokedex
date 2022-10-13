//
//  AlertBuilder.swift
//  Pokedex
//
//  Created by Eliano Corallo on 13/10/22.
//

import UIKit

struct AlertHandler {
    
    static func show(title: String, message: String) {
        let scenes = UIApplication.shared.connectedScenes
        guard let windowsScenes = scenes.first as? UIWindowScene,
              let window = windowsScenes.windows.first else {
            fatalError("Unable to find window")
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        window.rootViewController?.present(alert, animated: true)
    }
}
