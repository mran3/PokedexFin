//
//  PokemonDetailsPresenter.swift
//  Pokedex
//
//  Created by Andres Acevedo on 15.03.2021.
//

import UIKit

// MARK: - PokemonDetailsView

protocol PokemonDetailsView: class {
    func closeVC()
}

class PokemonDetailsPresenter {
    
    // MARK: - Private Properties
    
    weak fileprivate var pokemonDetailsView: PokemonDetailsView!
    
    // MARK: - Lifecycle
    
    init() {}
    
    func attachView(_ pokemonDetailsView: PokemonDetailsView) {
        self.pokemonDetailsView = pokemonDetailsView
    }
    
    func deatachView() {
        self.pokemonDetailsView = nil
    }
    
    func closeVC() {
        pokemonDetailsView.closeVC()
    }
}

