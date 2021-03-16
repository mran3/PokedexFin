//
//  ImageHelper.swift
//  Pokedex
//
//  Created by Andres Acevedo on 14.03.2021.
//

import UIKit

class ImageHelper {
    
    static func getImageForSkill(skillName: String) -> UIImage {
        switch skillName {
        case "bug":
            return #imageLiteral(resourceName: "Bug")
        case "dark":
            return #imageLiteral(resourceName: "Dark")
        case "dragon":
            return #imageLiteral(resourceName: "Dragon")
        case "electric":
            return #imageLiteral(resourceName: "Electric")
        case "fairy":
            return #imageLiteral(resourceName: "Fairy")
        case "fighting":
            return #imageLiteral(resourceName: "Fight")
        case "fire":
            return #imageLiteral(resourceName: "Fire")
        case "flying":
            return #imageLiteral(resourceName: "Flying")
        case "ghost":
            return #imageLiteral(resourceName: "Ghost")
        case "grass":
            return #imageLiteral(resourceName: "Grass")
        case "ground":
            return #imageLiteral(resourceName: "Ground")
        case "ice":
            return #imageLiteral(resourceName: "Ice")
        case "normal":
            return #imageLiteral(resourceName: "Normal")
        case "poison":
            return #imageLiteral(resourceName: "Poison")
        case "psychic":
            return #imageLiteral(resourceName: "Psychic")
        case "rock":
            return #imageLiteral(resourceName: "Rock")
        case "steel":
            return #imageLiteral(resourceName: "Steel")
        case "water":
            return #imageLiteral(resourceName: "Water")
        default:
            assertionFailure("Incorrect skill type")
            return UIImage()
        }
    }
    
    static func getImageForDescriptionScreen(skillName: String) -> UIImage {
        switch skillName {
        case "bug":
            return #imageLiteral(resourceName: "BugT")
        case "dark":
            return #imageLiteral(resourceName: "DarkT")
        case "dragon":
            return #imageLiteral(resourceName: "DragonT")
        case "electric":
            return #imageLiteral(resourceName: "ElectricT")
        case "fairy":
            return #imageLiteral(resourceName: "FairyT")
        case "fighting":
            return #imageLiteral(resourceName: "FightT")
        case "fire":
            return #imageLiteral(resourceName: "FireT")
        case "flying":
            return #imageLiteral(resourceName: "FlyingT")
        case "ghost":
            return #imageLiteral(resourceName: "GhostT")
        case "grass":
            return #imageLiteral(resourceName: "GrassT")
        case "ground":
            return #imageLiteral(resourceName: "GroundT")
        case "ice":
            return #imageLiteral(resourceName: "IceT")
        case "normal":
            return #imageLiteral(resourceName: "NormalT")
        case "poison":
            return #imageLiteral(resourceName: "PoisonT")
        case "psychic":
            return #imageLiteral(resourceName: "PsychicT")
        case "rock":
            return #imageLiteral(resourceName: "RockT")
        case "steel":
            return #imageLiteral(resourceName: "SteelT")
        case "water":
            return #imageLiteral(resourceName: "WaterT")
        default:
            assertionFailure("Incorrect skill type")
            return UIImage()
        }
    }
}
