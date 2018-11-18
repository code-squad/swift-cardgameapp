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
    func push(card: Card, index: Int?) {
        wasteModel.push(card)
    }
    
    func removeAll() {
        wasteModel.removeAll()
    }
    
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
