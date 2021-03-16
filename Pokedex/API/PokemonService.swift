//
//  PokemonService.swift
//  Pokedex
//
//  Created by Andres Acevedo on 13.03.2021.
//

import Foundation
import Moya

class PokemonService {
    
    static func getPokemonList(pagination: Pagination, completion: @escaping ([PokemonDetailsModel]) -> Void) {
        let provider = MoyaProvider<PokemonAPIType>()
        provider.request(.allPokemonList(limit: pagination.pageSize, offset:
                                            (pagination.pageNumber-1)*pagination.pageSize)) { result in
            switch result {
            case .success(let response):
                
                let models = try! response.map(PokemonResponses<PokemonListModel>.self).results
                let dispatchGroups = DispatchGroup()
                var detailedModels: [PokemonDetailsModel] = []
                for model in models {
                    dispatchGroups.enter()
                    getPokemonDetails(id: getId(from: model.url), completion: { detailedModel in
                        detailedModels.append(detailedModel)
                        dispatchGroups.leave()
                    })
                }
                dispatchGroups.notify(queue: .main, execute: {
                    completion(detailedModels.sorted(by: { (elem1, elem2) -> Bool in
                        return elem1.id < elem2.id
                    }))
                })
            case .failure:
                print("error PokemonListModel")
                completion([])
            }
        }
    }
    
    static func getPokemonDetails(id: Int, completion: @escaping (PokemonDetailsModel) -> Void) {
        let provider = MoyaProvider<PokemonAPIType>()
        provider.request(.pokemonDetails(id)) { result in
            switch result {
            case .success(let response):
                if let model = try? response.map(PokemonDetailsModel.self) {
                    completion(model)
                }
            case .failure:
                print("error PokemonDetailsModel")
            }
        }
    }
    
    static func getPokemonSpeciesModel(id: Int, completion: @escaping (PokemonSpeciesModel) -> Void) {
        let provider = MoyaProvider<PokemonAPIType>()
        provider.request(.getStatAboutPokemon(id)) { result in
            switch result {
            case .success(let response):
                if let model = try? response.map(PokemonSpeciesModel.self) {
                    completion(model)
                }
            case .failure:
                print("error PokemonSpeciesModel")
            }
        }
    }
    
    static func getPokemonDetailsSearch(text: String, completion: @escaping (PokemonDetailsModel?) -> Void) {
        let provider = MoyaProvider<PokemonAPIType>()
        provider.request(.getSearchedPokemon(text)) { result in
            switch result {
            case .success(let response):
                if let model = try? response.map(PokemonDetailsModel.self) {
                    completion(model)
                }
            case .failure:
                completion(nil)
                print("error PokemonDetailsModel")
            }
        }
    }
    
    static func getId(from str: String) -> Int {
        let idStr = str.split(separator: "/")
        let id = Int(idStr.last ?? "")
        return id ?? 0
    }
}

enum PokemonAPIType {
    case allPokemonList(limit: Int, offset: Int)
    case pokemonDetails(Int)
    case getSearchedPokemon(String)
    case getStatAboutPokemon(Int)
}

extension PokemonAPIType: TargetType {
    var sampleData: Data {
        Data()
    }
    
    public var baseURL: URL {
        return URL(string: "https://pokeapi.co/api/v2/")!
    }
    
    public var path: String {
        switch self {
        case .allPokemonList:
            return "pokemon"
        case let .pokemonDetails(id):
            return "pokemon/\(id)/"
        case let .getSearchedPokemon(text):
            return "pokemon/\(text)"
        case let .getStatAboutPokemon(id):
            return "pokemon-species/\(id)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .allPokemonList, .pokemonDetails, .getSearchedPokemon, .getStatAboutPokemon:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .pokemonDetails, .getSearchedPokemon, .getStatAboutPokemon:
            return .requestPlain
        case let .allPokemonList(limit, offset):
            return Task.requestParameters(parameters: ["limit" : limit, "offset" : offset], encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}

struct PokemonResponses<T: Codable>: Codable {
    let results: [T]
}

struct PokemonResponse<T: Codable>: Codable {
    let result: T
}
