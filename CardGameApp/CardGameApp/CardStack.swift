//
//  CardStack.swift
//  CardGameApp
//
//  Created by 김수현 on 2018. 7. 23..
//  Copyright © 2018년 김수현. All rights reserved.
//

import Foundation

enum Cards: Int {
    case sevenCards = 7, fiveCards = 5, invalidCards
}

enum Players: Int {
    case onePlayer = 1, twoPlayer, threePlayer, fourPlayer, invalidPlayer
}

class CardStack: CardStackPrintable {
    
    private var cardStack = [[Card]]()
    private var cards: Cards
    private var players: Players
    
    init(_ cards: Cards,_ players: Players) {
        self.cards = cards
        self.players = players
    }
    
    func makeCardStack(_ deck: CardDeck) -> [[Card]] {
        for _ in 0...self.players.rawValue {
            var tempCard = [Card]()
            for _ in 0..<self.cards.rawValue {
                tempCard.append(deck.removeOne().pick)
            }
            self.cardStack.append(tempCard)
        }
        return self.cardStack
    }
    
    func printCardStack(_ handler: (_ cards: [Card]) -> Void  ) {
        var player = 1
        for cards in self.cardStack {
            if player > self.players.rawValue {
                print("딜러 " , terminator: "")
                handler(cards)
            } else {
                print("참가자#\(player) " , terminator: "")
                handler(cards)
                player = player+1
            }
        }
    }
    
}
