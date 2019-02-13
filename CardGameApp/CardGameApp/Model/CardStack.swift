//
//  CardStack.swift
//  CardGame
//
//  Created by 조재흥 on 18. 12. 6..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

class CardStack : CustomStringConvertible {
    
    private var cards : [Card] {
        didSet {
            let userInfo: [String: [Card]] = [UserInfoKey.cards: self.cards]
            NotificationCenter.default.post(name: .cardStackDidChange,
                                            object: nil,
                                            userInfo: userInfo)
        }
    }
    
    var description: String {
        return "\(self.cards)"
    }
    
    private var pairs : [[Card]]?
    private var numberOfPair = [0,0,0,0,0]
    
    init(cards:[Card] = []) {
        self.cards = cards
    }
    
    func push(card:Card) {
        self.cards.append(card)
    }
    
    func pop() -> Card? {
        return cards.popLast()
    }
    
    func peek() -> Card? {
        return cards.last
    }
    
    func gatherInPairs(){
        var pairs = [[Card]]()
        
        for rank in Rank.allCases {
            let cards = self.cards.filter(){$0.isSame(rank: rank)}
            guard !cards.isEmpty else {continue}
            pairs.append(cards)
        }
        
        self.pairs = pairs.reversed()
    }
    
    func countNumberOfPair() {
        guard let pairs = self.pairs else {return}
        for pair in pairs {
            self.numberOfPair[pair.count] += 1
        }
    }
    
    func numberPair(_ number : Int) -> Int {
        return self.numberOfPair[number]
    }
    
    func maxValuedCardScore(bundle:Int) -> Int {
        guard let pairs = self.pairs else {return 0}
        let handRanking = pairs.filter(){$0.count == bundle}
        let maxValuedCard = handRanking[0].max { cardA, cardB in cardA.score() < cardB.score()}
        return maxValuedCard?.score() ?? 0
    }
}
