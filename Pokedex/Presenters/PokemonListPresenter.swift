//
//  PokemonListPresenter.swift
//  Pokedex
//
//  Created by Andres Acevedo on 15.03.2021.
//

import UIKit

// MARK: - PokemonListView

protocol PokemonListView: class {
    func setupAllUI()
    func getAllpokemonList(models: [PokemonDetailsModel])
    func getPokemonSearch(models: [PokemonDetailsModel])
    func openDetailsVC(with model: PokemonDetailsModel, text: String)
}

class PokemonListPresenter {
    
    // MARK: - Private Properties
    
    weak fileprivate var pokemonListView: PokemonListView!
    
    // MARK: - Lifecycle
    
    init() {}
    
    func attachView(_ pokemonListView: PokemonListView) {
        self.pokemonListView = pokemonListView
    }
    
    func deatachView() {
        self.pokemonListView = nil
    }
    
    func getAllPokemonList(pagination: Pagination) {
        PokemonService.getPokemonList(pagination: pagination, completion: { models in
            self.pokemonListView.getAllpokemonList(models: models)
        })
    }
    
    func setupAllUI() {
        pokemonListView.setupAllUI()
    }
    
    func getPokemonFromSearch(text: String) {
        PokemonService.getPokemonDetailsSearch(text: text, completion: { model in
            let detailedModels = model == nil ? [] : [model!]
            self.pokemonListView.getPokemonSearch(models: detailedModels)
        })
    }
    
    func openDetailsVC(with detailModel: PokemonDetailsModel) {
        PokemonService.getPokemonSpeciesModel(id: detailModel.id, completion: { model in
            let startTest = model.flavor_text_entries[6].flavor_text.trimmingCharacters(in: .whitespacesAndNewlines)
            let slicedText = startTest.replacingOccurrences(of: " ", with: "\n")
            let joinedText = slicedText.replacingOccurrences(of: "\n", with: " ")
            self.pokemonListView.openDetailsVC(with: detailModel, text: joinedText)
        })
    }
}
