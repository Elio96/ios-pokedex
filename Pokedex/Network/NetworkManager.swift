//
//  NetworkManager.swift
//  Pokedex
//
//  Created by Eliano Corallo on 12/10/22.
//

import Foundation

class NetworkManager {
    
    // This function accept a URLRequest and manage a result completion with success or error
    static func callApi<T: Decodable>(_ request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error{
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.nullResponse))
                }
                return
            }
            
            switch response.statusCode {
            case 200..<300:
                guard let data = data, let result = try? JSONDecoder().decode(T.self, from: data) else {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.wrongData))
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion(.success(result))
                }
                return
            default:
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.wrongStatusCode(response.statusCode)))
                }
                return
            }
        }
        task.resume()
    }
}
