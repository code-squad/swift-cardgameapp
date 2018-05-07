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
    func countOfStack(of: Int) -> Int
}


class FoundationDelegate: FoundationManageable{
    var foundations = [CardStack]()
    var lastCards: [Card?] {
        return foundations.map{ $0.last() }
    }

    init() { //초기상태는 빈 카드스택 4개
        for _ in 0..<4 {
            foundations.append(CardStack())
        }
    }

    func stackUp(newCard: Card) {
        if newCard.isDenominationA() {
            self.pushAce(newCard: newCard)
        } else {
            //another card
        }
        self.updateFoundation()
        NotificationCenter.default.post(name: .opendeckNeedsToBeDeleted, object: nil)
    }

    private func updateFoundation() {
        print("updateFoundation")
        NotificationCenter.default.post(name: .foundationUpdated, object: nil)
    }



    private func pushAce(newCard: Card) {
        for i in 0..<4 {
            if self.foundations[i].isEmpty() {
                self.foundations[i].stackUp(newCard: newCard)
                break
            }
        }
    }

    func countOfStack(of: Int) -> Int {
        return self.foundations[of].count()
    }

    func cardInTurn(at:(column: Int, row: Int)) -> Card {
        return self.foundations[at.column].getCard(at: at.row)
    }

}
