//
//  FoundationDelegate.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 5. 4..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

protocol FoundationManageable {
    func stackUp(newCard: Card)
    func cardInTurn(at:(column: Int, row: Int)) -> Card
    func countOfCards(of: Int) -> Int
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

    func isStackable(nextCard card: Card) -> [Bool] {
        if card.isDenominationA() {
            return self.foundations.map{ $0.isEmpty() }
        } else {
            var result = [Bool]()
            for foundation in foundations where foundation.isEmpty() {
                result.append(false)
            }
            for foundation in foundations where !foundation.isEmpty() {
                result.append(foundation.last()!.isLower(than: card))
            }
            return result
        }
    }

    func stackUp(newCard: Card) {
        if newCard.isDenominationA() {
            self.pushAce(newCard: newCard)
        } else {
            self.push(newCard: newCard)
        }
        updateFoundationView()
    }

    private func updateFoundationView() {
        NotificationCenter.default.post(name: .foundationUpdated, object: nil)
    }

    private func push(newCard: Card) {
        for i in FoundationDelegate.range where foundations[i].isEmpty() {
            continue
        }
        for i in FoundationDelegate.range where !foundations[i].isEmpty() {
            guard foundations[i].last()!.isLower(than: newCard) else { continue }
            foundations[i].push(newCard: newCard)
            break
        }
    }

    private func pushAce(newCard: Card) {
        for i in FoundationDelegate.range {
            guard self.foundations[i].isEmpty() else { continue }
            self.foundations[i].push(newCard: newCard)
            break
        }
    }

    func countOfCards(of column: Int) -> Int {
        return self.foundations[column].count()
    }

    func cardInTurn(at:(column: Int, row: Int)) -> Card {
        return self.foundations[at.column].getCard(at: at.row)
    }

}
