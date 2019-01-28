//
//  ScoreCalculator.swift
//  CardGame
//
//  Created by 조재흥 on 18. 12. 10..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct ScoreCalculator {    
    static func calculateScore(cardStack:CardStack) -> Int {
        cardStack.gatherInPairs()
        cardStack.countNumberOfPair()
        
        if cardStack.numberPair(4) == 1 {
            return cardStack.maxValuedCardScore(bundle: HandRanking.fourCard.bundle()) +
            HandRanking.fourCard.rawValue
        }
        
        if cardStack.numberPair(3) >= 1 {
            return cardStack.maxValuedCardScore(bundle: HandRanking.triple.bundle()) +
            HandRanking.triple.rawValue
        }
        
        if cardStack.numberPair(2) >= 2 {
            return cardStack.maxValuedCardScore(bundle: HandRanking.twoPair.bundle()) +
            HandRanking.twoPair.rawValue
        }
        
        if cardStack.numberPair(2) == 1 {
            return cardStack.maxValuedCardScore(bundle: HandRanking.onePair.bundle()) +
            HandRanking.onePair.rawValue
        }
        
        if cardStack.numberPair(1) >= 1 {
            return cardStack.maxValuedCardScore(bundle: HandRanking.highCard.bundle()) +
            HandRanking.highCard.rawValue
        }
        
        return 0
    }
}
