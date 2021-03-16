//
//  PockemonListTVCell.swift
//  Pokedex
//
//  Created by Andres Acevedo on 12.03.2021.
//

import UIKit

class PokemonListTVCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet fileprivate var pockemonImageView: UIImageView!
    @IBOutlet fileprivate var nameLabel: UILabel!
    @IBOutlet fileprivate var numberLabel: UILabel!
    @IBOutlet fileprivate var skillsStackView: UIStackView!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        pockemonImageView.image = nil
    }
    
    // MARK: - Public Methods
    
    func configureCell(with model: PokemonDetailsModel) {
        nameLabel.text = model.name.capitalized
        if model.id > 99 {
            numberLabel.text = "#\(model.id)"
        } else if model.id > 9 {
            numberLabel.text = "#0\(model.id)"
        } else {
            numberLabel.text = "#00\(model.id)"
        }
        pockemonImageView.load(urlString: model.sprites.other.officialArt.front_default)
        
        skillsStackView.removeAllArrangedSubviews()
        for type in model.types {
            setupSkillsStackView(skillName: type.type.name)
        }
        
    }
    
    // MARK: - Private Methods
    
    fileprivate func setupSkillsStackView(skillName: String) {
        let imageToAdd = ImageHelper.getImageForSkill(skillName: skillName)
        
        let imageView = UIImageView()
        imageView.image = imageToAdd
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = false
        imageView.contentMode = .scaleAspectFit
        skillsStackView.clipsToBounds = false
        skillsStackView.addArrangedSubview(imageView)
    }
}

extension PokemonListTVCell: NibLoadableView {}
