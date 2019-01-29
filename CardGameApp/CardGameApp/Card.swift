//
//  Card.swift
//  CardGame
//
//  Created by 조재흥 on 18. 12. 3..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

class Card : CustomStringConvertible {
    
    //MARK: - Properties
    
    var description: String {
        return "\(self.suit)\(self.rank)"
    }
    
    //MARK: Private
    
    private let suit: Suit
    private let rank: Rank
    private var isFront: Bool = true
    
    //MARK: - Methods
    //MARK: Initialization
    
    init(suit:Suit, rank:Rank) {
        self.suit = suit
        self.rank = rank
    }
    
    //MARK: Instance
    
    func isSame(rank: Rank) -> Bool {
        return self.rank == rank
    }
    
    func score() -> Int {
        return self.rank.rawValue * 10 + self.suit.rawValue
    }
    
    func imageName() -> String {
        return suit.firstLetter + rank.description
    }
}
