//
//  UIStackView+Extension.swift
//  Pokedex
//
//  Created by Andres Acevedo on 13.03.2021.
//

import UIKit

public extension UIStackView {
    func removeAllArrangedSubviews() {
        let views = self.arrangedSubviews
        views.forEach {
            self.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
