//
//  TargetInformation.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 3. 19..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

typealias DropableInformation = (targetParent: Receivable, availableIndexes: [CardIndexes])

class TargetInformation {
    private let targetParents: [Receivable]
    private let card: Card

    init(of card: Card) {
        targetParents = [FoundationsViewModel.sharedInstance(), SevenPilesViewModel.sharedInstance()]
        self.card = card
    }

    var parentModel: Receivable? {
        for target in targetParents where target.availablePosition(of: card) != nil {
            return target
        }
        return nil
    }

    var availableInformations: [DropableInformation] {
        var dropableInformations: [DropableInformation] = []
        for target in targetParents {
            let dropableInformation = (targetParent: target,
                                       availableIndexes: target.availablePositionsForDragging(of: card))
            dropableInformations.append(dropableInformation)
        }
        return dropableInformations
    }
}
