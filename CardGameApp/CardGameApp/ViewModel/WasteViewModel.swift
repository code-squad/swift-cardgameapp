//
//  WasteViewModel.swift
//  CardGameApp
//
//  Created by oingbong on 14/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

class WasteViewModel {
    private var wasteModel = CardStack()
    
    func list() -> [Card] {
        return wasteModel.list()
    }
}

extension WasteViewModel: SingleDataSource {
    func cardStack() -> CardStack {
        return wasteModel
    }
}

extension WasteViewModel: DeliverableViewModel {
    func postNotification() {
        let key = Notification.Name(NotificationKey.name.waste)
        NotificationCenter.default.post(name: key, object: nil)
    }
    
    func push(_ card: Card, at index: Int?) {
        wasteModel.push(card)
        postNotification()
    }
    
    func removeAll() {
        wasteModel.removeAll()
        postNotification()
    }
    
    func pop(at index: Int?) -> Card? {
        postNotification()
        return wasteModel.pop()
    }
    
    func info(at index: Int?) -> Card? {
        return wasteModel.info()
    }
    
    func lastCard(at index: Int?) -> Card? {
        return wasteModel.lastCard
    }

    func hasCard(at index: Int?) -> Bool {
        return wasteModel.count > 0 ? true : false
    }
}
