//
//  TableauViewModel.swift
//  CardGameApp
//
//  Created by oingbong on 14/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

class TableauViewModel {
    private var tableauModels: [CardStack]
    
    init() {
        var modelList = [CardStack]()
        for _ in 0..<Unit.tableauCount {
            let tableauModel = CardStack()
            modelList.append(tableauModel)
        }
        self.tableauModels = modelList
    }
    
    var count: Int {
        return self.tableauModels.count
    }
    
    func isEmpty(index: Int) -> Bool {
        return self.tableauModels[index].list().count == 0 ? true : false
    }
    
    func isOneStepHigher(with card: Card, at index: Int) -> Bool {
        guard tableauModels[index].hasCard() else { return false }
        guard let lastCard = tableauModels[index].lastCard else { return false }
        return card.isOneStepHigherWithAnotherShape(with: lastCard)
    }
    
    func lastCardPosition(at index: Int) -> DragTargetInfo {
        let cardCount = tableauModels[index].count
        let standardIndex = index + 1
        let standardCount = cardCount - 1
        let bonusY = 40
        let minX = Int(Unit.space) * standardIndex + Int(Unit.imageWidth) * standardCount
        let maxX = Int(Unit.space) * standardIndex + Int(Unit.imageWidth) * cardCount
        let minY = Int(Unit.defalutCardsYValue) + Int(Unit.cardSpace) * standardCount
        let maxY = Int(Unit.defalutCardsYValue) + Int(Unit.cardSpace) * standardCount + Int(Unit.imageWidth) + bonusY
        let locationDTO = DragTargetInfo(minX: minX, maxX: maxX, minY: minY, maxY: maxY)
        return locationDTO
    }
}

extension TableauViewModel {
    subscript(index: Int) -> CardStack {
        return tableauModels[index]
    }
}

extension TableauViewModel: MultipleDataSource {
    func card(_ handler: (Card, Int) -> Void) {
        for index in 0..<tableauModels.count {
            for card in tableauModels[index].list() {
                handler(card, index)
            }
        }
    }
}

extension TableauViewModel: DeliverableViewModel {
    func postNotification() {
        let key = Notification.Name(NotificationKey.name.tableau)
        NotificationCenter.default.post(name: key, object: nil)
    }
    
    func push(_ card: Card, at index: Int?) {
        guard let idx = index else { return }
        tableauModels[idx].push(card)
        postNotification()
    }
    
    func removeAll() {
        for index in 0..<tableauModels.count {
            tableauModels[index].removeAll()
        }
        postNotification()
    }
    
    func pop(at index: Int?) -> Card? {
        guard let idx = index else { return nil }
        postNotification()
        return tableauModels[idx].pop()
    }
    
    func info(at index: Int?) -> Card? {
        guard let idx = index else { return nil }
        return tableauModels[idx].info()
    }
    
    func lastCard(at index: Int?) -> Card? {
        guard let idx = index else { return nil }
        return tableauModels[idx].lastCard
    }
    
    func hasCard(at index: Int?) -> Bool {
        guard let idx = index else { return false }
        return tableauModels[idx].count > 0 ? true : false
    }
}
