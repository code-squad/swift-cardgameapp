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
    func cardStack() -> CardStack {
        return stockModel
    }
}

extension StockViewModel: BasicViewModel {
    func postNotification() {
        let name = Notification.Name(NotificationKey.name.stock)
        NotificationCenter.default.post(name: name, object: nil)
    }
    
    func push(card: Card, index: Int?) {
        stockModel.push(card)
        postNotification()
    }
    
    func removeAll() {
        stockModel.removeAll()
        postNotification()
    }
}
