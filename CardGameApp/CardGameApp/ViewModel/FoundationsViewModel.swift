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
        var flag = false
        guard validatePush(card: card) else {
            return false
        }
        if foundations.count == 0 {
            foundations.append(CardPack())
            foundations[0].append(card)
        } else {
            for index in 0..<foundations.count where foundations[index].last?.suit == card.suit {
                foundations[index].append(card)
                flag = true
            }
            if !flag {
                foundations.append(CardPack())
                foundations[foundations.count-1].append(card)
            }
        }
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

    func getTargetPosition(card: Card) -> Int? {
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
