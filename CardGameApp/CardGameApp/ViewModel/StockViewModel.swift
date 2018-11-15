//
//  StockViewModel.swift
//  CardGameApp
//
//  Created by oingbong on 14/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

class StockViewModel {
    private var stockModel = StockModel()
    
    func push(_ card: Card) {
        stockModel.push(card)
    }
    
    func pop() -> Card? {
        return stockModel.pop()
    }
    
    func removeAll() {
        stockModel.removeAll()
    }
}
