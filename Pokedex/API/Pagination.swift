//
//  Pagination.swift
//  Pokedex
//
//  Created by Andres Acevedo on 15.03.2021.
//

import Foundation

class Pagination {
    var pageSize: Int
    var pageNumber: Int
    var isEnabled: Bool
    
    private init(pageSize: Int, pageNumber: Int, isEnabled: Bool = true) {
        self.pageSize = pageSize
        self.pageNumber = pageNumber
        self.isEnabled = isEnabled
    }
    
    static func intialPage(pageSize: Int = 10) -> Pagination {
        return Pagination(pageSize: pageSize, pageNumber: 1)
    }
    
    func incrementPage() {
        pageNumber += 1
    }
    
    func decrementPage() {
        pageNumber -= 1
    }
    
    func reset() {
        isEnabled = true
        pageNumber = 1
    }
}
