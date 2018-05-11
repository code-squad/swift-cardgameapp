//
//  FoundationDelegate.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 5. 4..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

protocol FoundationManageable {
    func cardInTurn(at:(column: Int, row: Int)) -> Card
    func countOfCards(of: Int) -> Int
    func newStackUp(newCard: Card, column: Int)
}


class FoundationDelegate: FoundationManageable, Stackable {

    static let range: CountableRange = 0..<4
    var foundations = [CardStack]()
    var lastCards: [Card?] {
        return foundations.map{ $0.last() }
    }

    init() { //초기상태는 빈 카드스택 4개
        for _ in FoundationDelegate.range {
            foundations.append(CardStack())
        }
    }

//    func isStackable(nextCard card: Card) -> [Bool] {
//        if card.isDenominationA() {
//            return self.foundations.map{ $0.isEmpty() }
//        } else {
//            var result = [Bool]()
//            for foundation in foundations where foundation.isEmpty() {
//                result.append(false)
//            }
//            for foundation in foundations where !foundation.isEmpty() {
//                result.append(foundation.last()!.isLower(than: card))
//            }
//            return result
//        }
//    }

    func newStackable(nextCard card: Card) -> Int? {
        if card.isDenominationA() {
            for i in FoundationDelegate.range where foundations[i].isEmpty() {
                return i
            }
        } else {
            for i in FoundationDelegate.range where !foundations[i].isEmpty() {
                if foundations[i].last()!.isLower(than: card) {
                    return i
                }
            }
        }
        return nil
    }

    func newStackUp(newCard: Card, column: Int) {
        foundations[column].push(newCard: newCard)
    }

    private func updateFoundationView() {
        NotificationCenter.default.post(name: .foundationUpdated, object: nil)
    }

    func countOfCards(of column: Int) -> Int {
        return self.foundations[column].count()
    }

    func cardInTurn(at:(column: Int, row: Int)) -> Card {
        return self.foundations[at.column].getCard(at: at.row)
    }

}
