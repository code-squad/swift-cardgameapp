//
//  FoundationViewModel.swift
//  CardGameApp
//
//  Created by oingbong on 14/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

class FoundationViewModel {
    private var foundationModels: [CardStack]
    
    init() {
        var modelList = [CardStack]()
        for _ in 0..<Unit.foundationCount {
            let foundationModel = CardStack()
            modelList.append(foundationModel)
        }
        foundationModels = modelList
    }
    
    var count: Int {
        return foundationModels.count
    }
    
    func isEmpty(index: Int) -> Bool {
        return foundationModels[index].list().count == 0 ? true : false
    }
    
    func isOneStepLower(with card: Card, index: Int) -> Bool {
        guard foundationModels[index].hasCard() else { return false }
        guard let lastCard = foundationModels[index].lastCard else { return false }
        return card.isOneStepLowerWithEqualShape(with: lastCard)
    }
}

extension FoundationViewModel {
    subscript(index: Int) -> CardStack {
        return foundationModels[index]
    }
}

extension FoundationViewModel: MultipleDataSource {
    func cardStackList() -> [CardStack] {
        return foundationModels
    }
}

extension FoundationViewModel: BasicViewModel {
    func push(card: Card, index: Int?) {
        guard let idx = index else { return }
        foundationModels[idx].push(card)
    }
    
    func removeAll() {
        for index in 0..<foundationModels.count {
            foundationModels[index].removeAll()
        }
    }
}
