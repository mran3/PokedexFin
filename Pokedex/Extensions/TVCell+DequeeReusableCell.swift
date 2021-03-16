//
//  TVCell+Extension.swift
//  Pokedex
//
//  Created by Andres Acevedo on 12.03.2021.
//

import UIKit

extension UITableView {
    func register<T>(_: T.Type) where T: ReusableView & NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}
