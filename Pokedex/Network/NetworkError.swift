//
//  NetworkError.swift
//  Pokedex
//
//  Created by Eliano Corallo on 12/10/22.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case nullResponse
    case wrongStatusCode(Int)
    case wrongData
    
    var errorDescription: String? {
        switch self {
        case .nullResponse:
            return "Null Response"
        case .wrongStatusCode(let statusCode):
            return "Wrong Status Code \(statusCode)"
        case .wrongData:
            return "Wrong Data"
        }
    }
}
