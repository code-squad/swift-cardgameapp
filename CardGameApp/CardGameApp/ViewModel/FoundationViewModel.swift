//
//  FoundationViewModel.swift
//  CardGameApp
//
//  Created by oingbong on 14/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

class FoundationViewModel {
    private var foundationModels: [FoundationModel]
    
    init() {
        var modelList = [FoundationModel]()
        for _ in 0..<Unit.foundationCount {
            let foundationModel = FoundationModel()
            modelList.append(foundationModel)
        }
        self.foundationModels = modelList
    }
    
    var count: Int {
        return self.foundationModels.count
    }
    
    func push(_ card: Card, index: Int) {
        foundationModels[index].push(card)
    }
    
    func removeAll() {
        for index in 0..<foundationModels.count {
            foundationModels[index].removeAll()
        }
    }
    
    func isEmpty(index: Int) -> Bool {
        return self.foundationModels[index].list().count == 0 ? true : false
    }
    
    private func lastCard(index: Int) -> Card? {
        return foundationModels[index].lastCard
    }
    
    func isOneStepLower(with card: Card, index: Int) -> Bool {
        guard foundationModels[index].hasCard() else { return false }
        guard let lastCard = foundationModels[index].lastCard else { return false }
        return card.isOneStepLowerWithEqualShape(with: lastCard)
    }
}

extension FoundationViewModel {
    subscript(index: Int) -> FoundationModel {
        return foundationModels[index]
    }
}
