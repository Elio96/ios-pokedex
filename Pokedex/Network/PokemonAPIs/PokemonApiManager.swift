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
    
    private let pokemonCoreDataManager: PokemonCoreDataManager<Pokemon>
    
    private init() {
        self.pokemonCoreDataManager = PokemonCoreDataManager(managedObjectContext: CoreDataManager.shared.managedObjectContext)
    }
    
    //store the current response and is used to call the new pokemon with "next" url updated
    private var pokemonsResponse: PokemonsResponse?
    
    //is a property that download the core data items once
    private var offlineJustLoaded: Bool = false
    
    //Fetch the complete list of pokemons combining the two network calls below if the internet connection is reachable
    //Otherwise, fetch the pokemons saved in CoreData
    func fetchPokemons(_ completion: @escaping (Result<[PokemonModel], Error>) -> Void) {
        ReachabilityHandler.isUnreachable { [weak self] _ in
            guard let self = self, !self.offlineJustLoaded else { return }
            self.pokemonCoreDataManager.fetchFromStorage { results in
                switch results {
                case .success(let pokemons):
                    if let pokemons = pokemons{
                        let model = pokemons.compactMap({$0.toModel()})
                        self.offlineJustLoaded = true
                        completion(.success(model))
                    }
                case .failure(let err):
                    completion(.failure(err))
                }
            }
        }
        ReachabilityHandler.isReachable { [weak self] _ in
            guard let self = self else { return }
            Task {
                do {
                    let res = try await self.getPokemons(url: self.pokemonsResponse?.next)
                    self.pokemonsResponse = res
                    var pokemonModels = [PokemonModel]()
                    for pokemonItem in res.results {
                        let pokemonModel = try await self.getPokemonDetails(from: pokemonItem.url)
                        pokemonModels.append(pokemonModel)
                    }
                    self.pokemonCoreDataManager.saveToStorage(models: pokemonModels, desiredToConvert: Pokemon.self)
                    completion(.success(pokemonModels))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
    }
    
    //Fetch the current pokemon details with given url
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
    
    //It fetch the main pokemon object with the url passed as parameter
    //if url is nil, fetch the first object with the standard url
    private func getPokemons(url: String?) async throws -> PokemonsResponse {
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
