//
//  ViewController.swift
//  Pokedex
//
//  Created by Andres Acevedo on 12.03.2021.
//

import UIKit

class PokemonListVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet fileprivate var titleLabel: UILabel!
    @IBOutlet fileprivate var searchTextField: UITextField!
    @IBOutlet fileprivate var tableView: UITableView!
    
    // MARK: - Fileprivate variables
    
    fileprivate let pokemonListPresenter = PokemonListPresenter()
    fileprivate var pokemonModels: [PokemonDetailsModel] = []
    fileprivate var cellHeight: CGFloat = 75
    
    fileprivate let pagination = Pagination.intialPage(pageSize: 40)
    fileprivate var isNeedToObserveCollectionViewScroll = true
    fileprivate var itemsFromRequest = 0
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        pokemonListPresenter.attachView(self)
        super.viewDidLoad()
        
        pokemonListPresenter.setupAllUI()
        pokemonListPresenter.getAllPokemonList(pagination: pagination)
    }
    
    deinit {
        pokemonListPresenter.deatachView()
    }
    
    // MARK: - Fileprivates methods
    
    fileprivate func setupSearchTextField() {
        searchTextField.setLeftPaddingPoints(36)
        searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        let color = #colorLiteral(red: 0.2980392157, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
        let placeholder = "Search"
        searchTextField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
                                                                    NSAttributedString.Key.foregroundColor : color,
                                                                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)])
    }
    
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PokemonListTVCell.self)
    }
    
    fileprivate func getAllPokemon(models: [PokemonDetailsModel]) {
        if models.count < pagination.pageSize {
            pagination.isEnabled = false
        }
        if pagination.pageNumber == 1 {
            pokemonModels = models
            tableView.reloadData()
        } else {
            itemsFromRequest = models.count
            pokemonModels.append(contentsOf: models)
            insertRowsAfterPagination()
        }
    }
    
    fileprivate func getPokemonFromSearch(models: [PokemonDetailsModel]) {
        pokemonModels = models
        tableView.reloadData()
    }
    
    fileprivate func insertRowsAfterPagination() {
        UIView.performWithoutAnimation {
            self.tableView.performBatchUpdates({
                let leftSide = (self.pagination.pageNumber - 1) * self.pagination.pageSize
                let rightSide = (self.pagination.pageNumber - 1) * self.pagination.pageSize + self.itemsFromRequest
                var indexPaths = [IndexPath]()
                for index in leftSide ..< rightSide {
                    indexPaths.append(IndexPath(row: index, section: 0))
                }
                self.tableView.insertRows(at: indexPaths, with: .automatic)
            }, completion: { _ in
                if self.pagination.isEnabled {
                    self.isNeedToObserveCollectionViewScroll = true
                }
            })
        }
    }
    
    @objc fileprivate func textFieldDidChange() {
        pagination.reset()
        if (searchTextField.text?.isEmpty ?? true) {
            pokemonListPresenter.getAllPokemonList(pagination: pagination)
        } else {
            pokemonListPresenter.getPokemonFromSearch(text: searchTextField.text!)
        }
    }
}

// MARK: - PokemonListView

extension PokemonListVC: PokemonListView {
    func getAllpokemonList(models: [PokemonDetailsModel]) {
        getAllPokemon(models: models)
    }
    
    func setupAllUI() {
        setupSearchTextField()
        setupTableView()
    }
    
    func getPokemonSearch(models: [PokemonDetailsModel]) {
        getPokemonFromSearch(models: models)
    }
    
    func openDetailsVC(with model: PokemonDetailsModel, text: String) {
        openPokemonDetailsVC(with: model, text: text)
    }
}

// MARK: - Navigation

extension PokemonListVC {
    fileprivate func openPokemonDetailsVC(with model: PokemonDetailsModel, text: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PokemonDetailsVC") as! PokemonDetailsVC
        vc.model = model
        vc.descriptiomText = text
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension PokemonListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }
    
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PokemonListTVCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        
        cell.configureCell(with: pokemonModels[indexPath.row])
        return cell
    }
    
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pokemonListPresenter.openDetailsVC(with: pokemonModels[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isNeedToObserveCollectionViewScroll {
            if scrollView.reachedBottom(offsetFromBottom: 1200) {
                pagination.incrementPage()
                pokemonListPresenter.getAllPokemonList(pagination: pagination)
                isNeedToObserveCollectionViewScroll = false
            }
        }
    }
}
