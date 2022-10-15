//
//  PokemonApiManager.swift
//  Pokedex
//
//  Created by Eliano Corallo on 13/10/22.
//

import Foundation
import CoreData

class PokemonApiManager {
    
    static let shared = PokemonApiManager()
    
    private let pokemonCoreDataManager: PokemonCoreDataManager
    
    private init() {
        self.pokemonCoreDataManager = PokemonCoreDataManager(managedObjectContext: CoreDataManager.shared.managedObjectContext, entityName: "Pokemon")
    }
    
    private var pokemonsResponse: PokemonsResponse?
    
    func fetchPokemons(_ completion: @escaping (Result<[PokemonModel], Error>) -> Void) {
        Task {
            do {
                let res = try await getPokemons(url: pokemonsResponse?.next)
                self.pokemonsResponse = res
                var pokemonModels = [PokemonModel]()
                for pokemonItem in res.results {
                    let pokemonModel = try await getPokemonDetails(from: pokemonItem.url)
                    pokemonModels.append(pokemonModel)
                }
                pokemonCoreDataManager.saveToStorage(models: pokemonModels)
                completion(.success(pokemonModels))
            } catch let error {
                pokemonCoreDataManager.fetchFromStorage { results in
                    switch results {
                    case .success(let pokemons):
                        if let pokemons = pokemons{
                            let model = pokemons.compactMap({$0.toModel()})
                            completion(.success(model))
                        }
                    case .failure(let err):
                        completion(.failure(err))
                    }
                }
                completion(.failure(error))
            }
        }
    }
    
    private func getPokemonDetails(from url: String) async throws -> PokemonModel {
        guard let url = URL(string: url) else { throw NSError(domain: "Error parsing url", code: -1) }
        let request = URLRequest(url: url)
        return try await withCheckedThrowingContinuation({ continuation in
            NetworkManager.callApi(request) { (result: Result<PokemonModel, Error>) -> Void in
                switch result {
                case .success(let resp):
                    continuation.resume(returning: resp)
                case .failure(let err):
                    continuation.resume(throwing: err)
                }
            }
        })
    }
    
    private func getPokemons(url: String?) async throws -> PokemonsResponse {
//        guard var reqURL = URL(string: "https://pokeapi.co/api/v2/pokemon") else { throw NSError(domain: "Error parsing url", code: -1) }
        let reqURL: URL
        if let urlString = url, let url = URL(string: urlString) {
            reqURL = url
        } else {
            
            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon") else { throw NSError(domain: "Error parsing url", code: -1) }
            reqURL = url
        }
        let urlRequest = URLRequest(url: reqURL)
        return try await withCheckedThrowingContinuation({ continuation in
            NetworkManager.callApi(urlRequest) { (result: Result<PokemonsResponse, Error>) -> Void in
                switch result {
                case .success(let resp):
                    continuation.resume(returning: resp)
                case .failure(let err):
                    continuation.resume(throwing: err)
                }
            }
        })
    }
}
