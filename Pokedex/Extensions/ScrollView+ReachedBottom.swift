//
//  ScrollView+Extension.swift
//  Pokedex
//
//  Created by Family on 15.03.2021.
//

import UIKit

extension UIScrollView {
    func reachedBottom(offsetFromBottom: CGFloat? = 0.0) -> Bool {
        let visibleHeight = self.frame.height - self.contentInset.top - self.contentInset.bottom
        let y = self.contentOffset.y + self.contentInset.top
        let threshold = max(0.0, self.contentSize.height - visibleHeight - (offsetFromBottom ?? 0))
        
        return y > threshold
    }
}
