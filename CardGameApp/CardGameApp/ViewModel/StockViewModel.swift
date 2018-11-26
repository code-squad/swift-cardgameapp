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
}

extension StockViewModel: SingleDataSource {
    func card(_ handler: (Card) -> Void) {
        for card in stockModel.list() {
            card.flipCondition(with: .back)
            handler(card)
        }
    }
}

extension StockViewModel: DeliverableViewModeling {
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
    
    func pop(at index: Int?, sub subIndex: Int?) -> Card? {
        postNotification()
        return stockModel.pop()
    }
    
    func info(at index: Int?) -> Card? {
        return stockModel.info()
    }
    
    func lastCard(at index: Int?) -> Card? {
        return stockModel.lastCard
    }
    
    func hasCard(at index: Int?) -> Bool {
        return stockModel.count > 0 ? true : false
    }
}
