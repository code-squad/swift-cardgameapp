//
//  FoundationViewModel.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 1. 30..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

class FoundationsViewModel {
    private var foundations: [CardPack] = [CardPack]() {
        didSet {
            var cardImages: [String?] = []
            foundations.forEach({cardImages.append($0.last?.image)})
            NotificationCenter.default.post(name: .foundation,
                                            object: self,
                                            userInfo: [Keyword.foundationImages.value: cardImages])
        }
    }

    func push(card: Card) -> Bool {
        if !validatePush(card: card) { return false }
        for index in foundations.indices where foundations[index].last?.suit == card.suit {
            foundations[index].append(card)
            return true
        }
        foundations.append([card])
        return true
    }

    private func validatePush(card: Card) -> Bool {
        if card.rank == Card.Rank.ace {
            return true
        }
        for cardPack in foundations {
            guard cardPack.last?.suit == card.suit else { continue }
            if (cardPack.last?.rank.rawValue)! == card.rank.rawValue - 1 {
                return true
            }
        }
        return false
    }

    func getTargetPosition(of card: Card) -> Int? {
        var targetPosition: Int?
        if card.rank == Card.Rank.ace {
            return foundations.count
        }
        for index in foundations.indices {
            guard foundations[index].last?.suit == card.suit else { continue }
            if (foundations[index].last?.rank.rawValue)! == card.rank.rawValue - 1 {
                targetPosition = index
            }
        }
        return targetPosition
    }

    func reset() {
        foundations = []
    }
}
