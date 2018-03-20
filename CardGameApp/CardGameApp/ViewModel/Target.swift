//
//  Target.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 3. 14..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

//typealias DropableInformation = (targetParent: Receivable, availableIndexes: [CardIndexes])
//struct Target {
//    static private let targetParents = [FoundationsViewModel.sharedInstance(),
//                          SevenPilesViewModel.sharedInstance()] as [Receivable]
//    static func getParent(of card: Card) -> Receivable? {
//        for target in targetParents where target.availablePosition(of: card) != nil {
//            return target
//        }
//        return nil
//    }
//
//    static func availableInformations(of card: Card) -> [DropableInformation] {
//        var dropableInformations: [DropableInformation] = []
//        for target in targetParents {
//            let dropableInformation = (targetParent: target,
//                                       availableIndexes: target.availablePositionsForDragging(of: card))
//            dropableInformations.append(dropableInformation)
//        }
//        return dropableInformations
//    }
//}

