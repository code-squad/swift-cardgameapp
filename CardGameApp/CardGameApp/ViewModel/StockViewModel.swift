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
        postNotification()
        return stockModel.pop()
    }
}

extension StockViewModel: SingleDataSource {
    func card(_ handler: (Card) -> Void) {
        for card in stockModel.list() {
            card.flipCondition(with: .back)
            handler(card)
        }
    }
}

extension StockViewModel: BasicViewModel {
    func postNotification() {
        let key = Notification.Name(NotificationKey.name.stock)
        NotificationCenter.default.post(name: key, object: nil)
    }
    
    func push(_ card: Card, at index: Int?) {
        stockModel.push(card)
        postNotification()
    }
    
    func removeAll() {
        stockModel.removeAll()
        postNotification()
    }
}
