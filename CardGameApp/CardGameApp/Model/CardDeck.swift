//
//  CardDeck.swift
//  CardGame
//
//  Created by YOUTH on 2018. 1. 9..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

class CardDeck: CustomStringConvertible {
    private var cards = [Card]()
    var description: String {
        return "총 \(self.cards.count)장의 카드가 남아있습니다.\n"
    }
    
    init() {
        var cards = [Card]()
        for shape in Suit.allValues {
            for number in Denomination.allValues {
                cards.append(Card(suit: shape, denomination: number))
            }
        }
        self.cards = cards
    }
    
    func reset() -> CardDeck {
        return CardDeck()
    }
    
    func shuffle() {
        var tempCards = self.cards
        var shuffledCards = [Card]()
        
        while 0 < tempCards.count {
            let randomIndex = Int(arc4random_uniform(UInt32(tempCards.count)))
            let pickedCard = tempCards.remove(at: randomIndex)
            shuffledCards.append(pickedCard)
        }
        self.cards = shuffledCards
    }
    
    func removeOne() -> Card {
        let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
        let pickedCard = self.cards.remove(at: randomIndex)
        return pickedCard
    }
    
    func count() -> Int {
        return self.cards.count
    }
    
    func makeShuffleMessage() -> String {
        return "전체 \(self.cards.count)장의 카드를 섞었습니다.\n"
    }

    func makeCards(_ countOfCards: Int) -> [Card] {
        var cards = [Card]()
        for _ in 0..<countOfCards {
            let picked = removeOne()
            cards.append(picked)
        }
        return cards
    }

    func makeStack(cards: [Card]) -> CardStack {
        return CardStack(cards)
    }

    func hasEnoughCards(numberOfNeeded: Int) -> Bool {
        if numberOfNeeded < self.cards.count {
            return true
        }
        return false
    }

}


extension CardDeck {
    
    enum Suit: String, EnumCollection, Comparable {
        case heart = "♥️"
        case diamond = "♦️"
        case clover = "♣️"
        case spade = "♠️"

        static func <(lhs: CardDeck.Suit, rhs: CardDeck.Suit) -> Bool {
            return lhs.hashValue < rhs.hashValue
        }

        static func ==(lhs: CardDeck.Suit, rhs: CardDeck.Suit) -> Bool {
            return lhs.hashValue == rhs.hashValue
        }
    }
    
    enum Denomination: Int, CustomStringConvertible, EnumCollection, Comparable {
        case two = 2, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, ace
        
        var description: String {
            switch self {
            case .ace: return "A"
            case .eleven: return "J"
            case .twelve: return "Q"
            case .thirteen: return "K"
            default: return String(self.rawValue)
            }
        }

        static func <(lhs: CardDeck.Denomination, rhs: CardDeck.Denomination) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }

        static func ==(lhs: CardDeck.Denomination, rhs: CardDeck.Denomination) -> Bool {
            return lhs.rawValue == rhs.rawValue
        }

        func isContinuous(next: CardDeck.Denomination) -> Bool {
            return self.rawValue == (next.rawValue + 1)
        }
    }
   
}

    

