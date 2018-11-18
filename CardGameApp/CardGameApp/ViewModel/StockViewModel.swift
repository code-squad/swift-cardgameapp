//
//  StockViewModel.swift
//  CardGameApp
//
//  Created by oingbong on 14/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

class StockViewModel {
    private var stockModel = CardStack()
    
    func pop() -> Card? {
        return stockModel.pop()
    }
}

extension StockViewModel: SingleDataSource {
    func cardStack() -> CardStack {
        return stockModel
    }
}

extension StockViewModel: BasicViewModel {
    func push(card: Card, index: Int?) {
        stockModel.push(card)
    }
    
    func removeAll() {
        stockModel.removeAll()
    }
}
