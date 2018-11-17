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
    
    func push(_ card: Card) {
        wasteModel.push(card)
    }
    
    func pop() -> Card? {
        return wasteModel.pop()
    }
    
    func removeAll() {
        wasteModel.removeAll()
    }
    
    func list() -> [Card] {
        return wasteModel.list()
    }
    
    func lastCard() -> Card? {
        return wasteModel.lastCard
    }
    
    func info() -> Card? {
        return wasteModel.info()
    }
}

extension WasteViewModel: DeliverableViewModel {
    
    func pop(index: Int?) -> Card? {
        return wasteModel.pop()
    }
    
    func info(index: Int?) -> Card? {
        return wasteModel.info()
    }
    
    func lastCard(index: Int?) -> Card? {
        return wasteModel.lastCard
    }
    
    func hasCard(index: Int?) -> Bool {
        return wasteModel.count > 0 ? true : false
    }
}

extension WasteViewModel: SingleDataSource {
    func cardStack() -> CardStack {
        return wasteModel
    }
}
