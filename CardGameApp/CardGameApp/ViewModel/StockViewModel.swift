//
//  StockViewModel.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 24..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

class StockViewModel {
    var stockCards = [Card]() {
        willSet {
            NotificationCenter.default.post(
                name: .didChangeStockCardNotification,
                object: self,
                userInfo: ["cards": newValue]
            )
        }
    }

    init(_ cards: [Card]) {
        stockCards = cards
    }

    func refresh(with cards: [Card]) {
        stockCards.removeAll()
        stockCards.append(contentsOf: cards)
    }

    func pop() -> Card {
        return stockCards.removeLast()
    }
}

extension Notification.Name {
    static let didChangeStockCardNotification = Notification.Name(rawValue: "didChangeStockCard")
}
