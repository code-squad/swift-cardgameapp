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
    
    func isOneStepHigher(with card: Card, index: Int) -> Bool {
        guard tableauModels[index].hasCard() else { return false }
        guard let lastCard = tableauModels[index].lastCard else { return false }
        return card.isOneStepHigherWithAnotherShape(with: lastCard)
    }
}

extension TableauViewModel {
    subscript(index: Int) -> CardStack {
        return tableauModels[index]
    }
}

extension TableauViewModel: MultipleDataSource {
    func cardStackList() -> [CardStack] {
        return tableauModels
    }
}

extension TableauViewModel: DeliverableViewModel {
    func push(card: Card, index: Int?) {
        guard let idx = index else { return }
        tableauModels[idx].push(card)
    }
    
    func removeAll() {
        for index in 0..<tableauModels.count {
            tableauModels[index].removeAll()
        }
    }
    
    func pop(index: Int?) -> Card? {
        guard let idx = index else { return nil }
        return tableauModels[idx].pop()
    }
    
    func info(index: Int?) -> Card? {
        guard let idx = index else { return nil }
        return tableauModels[idx].info()
    }
    
    func lastCard(index: Int?) -> Card? {
        guard let idx = index else { return nil }
        return tableauModels[idx].lastCard
    }
    
    func hasCard(index: Int?) -> Bool {
        guard let idx = index else { return false }
        return tableauModels[idx].count > 0 ? true : false
    }
}
