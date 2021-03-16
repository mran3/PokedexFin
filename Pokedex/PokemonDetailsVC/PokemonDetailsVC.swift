//
//  PokemonDetailsVC.swift
//  Pokedex
//
//  Created by Andres Acevedo on 12.03.2021.
//

import UIKit

class PokemonDetailsVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet fileprivate var backView: UIView!
    @IBOutlet fileprivate var pokeImageView: UIImageView!
    @IBOutlet fileprivate var nameLabel: UILabel!
    @IBOutlet fileprivate var skillsStackView: UIStackView!
    @IBOutlet fileprivate var pokeInfoTextLabel: UILabel!
    @IBOutlet fileprivate var pokeHPValue: UILabel!
    @IBOutlet fileprivate var pokeHPProgresView: UIView!
    @IBOutlet fileprivate var pokeATKValue: UILabel!
    @IBOutlet fileprivate var pokeATKProgresView: UIView!
    @IBOutlet fileprivate var pokeDEFValue: UILabel!
    @IBOutlet fileprivate var pokeDEFProgresView: UIView!
    @IBOutlet fileprivate var pokeSATKValue: UILabel!
    @IBOutlet fileprivate var pokeSATKProgresView: UIView!
    @IBOutlet fileprivate var pokeSDEFValue: UILabel!
    @IBOutlet fileprivate var pokeSDEFProgresView: UIView!
    @IBOutlet fileprivate var pokeSPDValue: UILabel!
    @IBOutlet fileprivate var pokeSPDProgresView: UIView!
    
    
    // MARK: - Fileprivate variables
    
    fileprivate let pokemonDetailsPresenter = PokemonDetailsPresenter()
    
    // MARK: - Public variables
    
    var model: PokemonDetailsModel!
    var descriptiomText: String!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        pokemonDetailsPresenter.attachView(self)
        super.viewDidLoad()
        
        configureVC()
        setupButton()
    }
    
    deinit {
        pokemonDetailsPresenter.deatachView()
    }
    
    // MARK: - Fileprivates methods
    
    fileprivate func setupButton() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(backPressed))
        backView.addGestureRecognizer(tap)
    }
    
    fileprivate func configureVC() {
        pokeImageView.load(urlString: model.sprites.other.officialArt.front_default)
        nameLabel.text = model.name.capitalized
        pokeInfoTextLabel.text = descriptiomText
        setupSkillsStackView()
        setupStatInfo()
    }
    
    fileprivate func setupStatInfo() {
        drawProgresGradientView(to: pokeHPProgresView, value: model.stats[0].base_stat)
        drawProgresGradientView(to: pokeATKProgresView, value: model.stats[1].base_stat)
        drawProgresGradientView(to: pokeDEFProgresView, value: model.stats[2].base_stat)
        drawProgresGradientView(to: pokeSATKProgresView, value: model.stats[3].base_stat)
        drawProgresGradientView(to: pokeSDEFProgresView, value: model.stats[4].base_stat)
        drawProgresGradientView(to: pokeSPDProgresView, value: model.stats[5].base_stat)
        
        setStatLabel(label: pokeHPValue, stat: model.stats[0].base_stat)
        setStatLabel(label: pokeATKValue, stat: model.stats[1].base_stat)
        setStatLabel(label: pokeDEFValue, stat: model.stats[2].base_stat)
        setStatLabel(label: pokeSATKValue, stat: model.stats[3].base_stat)
        setStatLabel(label: pokeSDEFValue, stat: model.stats[4].base_stat)
        setStatLabel(label: pokeSPDValue, stat: model.stats[5].base_stat)
    }
    
    fileprivate func setupSkillsStackView() {
        skillsStackView.removeAllArrangedSubviews()
        for type in model.types {
            setupSkillsStackView(skillName: type.type.name)
        }
    }
    
    fileprivate func setStatLabel(label: UILabel, stat: Int) {
        if stat > 99 {
            label.text = "\(stat)"
        } else if stat > 9 {
            label.text = "0\(stat)"
        } else {
            label.text = "00\(stat)"
        }
    }
    
    fileprivate func setupSkillsStackView(skillName: String) {
        let imageToAdd = ImageHelper.getImageForDescriptionScreen(skillName: skillName)
        let imageView = UIImageView()
        imageView.image = imageToAdd
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = false
        imageView.contentMode = .scaleAspectFit
        skillsStackView.clipsToBounds = false
        skillsStackView.addArrangedSubview(imageView)
    }
    
    fileprivate func drawProgresGradientView(to view: UIView, value: Int) {
        let layer = CAGradientLayer()
        layer.frame = CGRect(origin: view.bounds.origin,
                             size: CGSize(width: ((view.bounds.width * CGFloat(value)) / 100) + CGFloat(value)/9,
                                          height: view.bounds.height))
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        let startcolor = #colorLiteral(red: 0.4235294118, green: 0.7411764706, blue: 0.8941176471, alpha: 1)
        let endColor = #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8666666667, alpha: 1)
        layer.colors = [startcolor.cgColor, endColor.cgColor]
        layer.cornerRadius = 4
        view.layer.addSublayer(layer)
    }
    
    @objc func backPressed() {
        pokemonDetailsPresenter.closeVC()
    }
}

// MARK: - PokemonListView

extension PokemonDetailsVC: PokemonDetailsView {
    func closeVC() {
        navigationController?.popViewController(animated: true)
    }
}
