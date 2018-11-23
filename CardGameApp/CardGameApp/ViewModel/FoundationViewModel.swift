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
    
    func lastCardPosition(at index: Int) -> DragTargetInfo {
        let standardIndex = index + 1
        let minX = Int(Unit.space) * standardIndex + Int(Unit.imageWidth) * index
        let maxX = minX + Int(Unit.imageWidth)
        let minY = Int(Unit.foundationYValue)
        let maxY = minY + Int(Unit.imageWidth)
        print("\(minX)/\(maxX)/\(minY)/\(maxY)")
        let dragTargetInfo = DragTargetInfo(minX: minX, maxX: maxX, minY: minY, maxY: maxY)
        return dragTargetInfo
    }
}

extension FoundationViewModel {
    subscript(index: Int) -> CardStack {
        return foundationModels[index]
    }
}

extension FoundationViewModel: MultipleDataSource {
    func card(_ handler: (Card, Int) -> Void) {
        for index in 0..<foundationModels.count {
            for card in foundationModels[index].list() {
                handler(card, index)
            }
        }
    }
}

extension FoundationViewModel: BasicViewModel {
    func postNotification() {
        let key = Notification.Name(NotificationKey.name.foundation)
        NotificationCenter.default.post(name: key, object: nil)
    }
    
    func push(_ card: Card, at index: Int?) {
        guard let idx = index else { return }
        foundationModels[idx].push(card)
        postNotification()
    }
    
    func removeAll() {
        for index in 0..<foundationModels.count {
            foundationModels[index].removeAll()
        }
        postNotification()
    }
}
