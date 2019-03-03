//
//  CardStack.swift
//  CardGame
//
//  Created by 조재흥 on 18. 12. 6..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

class CardStack : CustomStringConvertible {
    
    //MARK: - Properties
    //MARK: Private

    private var cards : [Card] {
        didSet {
            let countOfLatestCards = cards.count - oldValue.count
            if countOfLatestCards > 0 {
                postAddedCardsInfo(countOfLatestCards)
            }
            if countOfLatestCards < 0 {
                postPoppedCountInfo(countOfLatestCards)
            }
        }
    }
    
    private func postAddedCardsInfo(_ count: Int) {
        let addedCards = cards.suffix(count)
        NotificationCenter.default.post(name: addedCardsNotificationName(),
                                        object: self,
                                        userInfo: [UserInfoKey.addedCards: Array(addedCards)])
    }
    
    func addedCardsNotificationName() -> Notification.Name {
        return .cardStackDidAdd
    }
    
    private func postPoppedCountInfo(_ count: Int) {
        let countOfPoppedCards = abs(count)
        NotificationCenter.default.post(name: poppedCountNotificationName(),
                                        object: self,
                                        userInfo: [UserInfoKey.countOfPoppedCards: countOfPoppedCards])
    }
    
    func poppedCountNotificationName() -> Notification.Name {
        return .cardStackDidPop
    }

    var description: String {
        return "\(self.cards)"
    }
    
    private var pairs : [[Card]]?
    private var numberOfPair = [0,0,0,0,0]
    
    //MARK: - Methods
    //MARK: Initialization
    
    init(cards:[Card] = []) {
        self.cards = cards
    }
    
    //MARK: Instance
    
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

    func put(stack: CardStack) {
        let cards = stack.cards
        self.cards.append(contentsOf: cards)
    }
    
    func putWithReverse(stack: CardStack) {
        let cards = stack.cards.reversed()
        stack.cards.removeAll()
        self.cards.append(contentsOf: cards)
    }
    
    func empty() {
        self.cards.removeAll()
    }
    
    func isEmpty() -> Bool {
        return self.cards.isEmpty
    }
}
