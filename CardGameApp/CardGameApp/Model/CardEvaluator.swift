//
//  CardEvaluator.swift
//  CardGameApp
//
//  Created by 권재욱 on 2018. 3. 30..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import Foundation

struct CardEvaluator {
    
    private var foundation : [Card] = []
    private var openedCard : Card
    private var cardStacks : [[Card]] = []
    
    mutating func setOpenedCard(_ card: Card) {
        self.openedCard = card
    }
    
    mutating func addOneStack(_ stack: [Card]) {
        self.cardStacks.append(stack)
    }
    
}
