//
//  FoundationViewModel.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 1. 30..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

class FoundationsViewModel: PilesVMProtocol {
    private var foundations: [CardPack] = [CardPack]()

    func push(card: Card) {
        var flag = false
        if foundations.count == 0 {
            foundations.append(CardPack())
            foundations[0].append(card)
        } else {
            for i in 0..<foundations.count {
                if foundations[i].last?.suit == card.suit {
                    foundations[i].append(card)
                    flag = true
                }
            }
            if !flag {
                foundations.append(CardPack())
                foundations[foundations.count-1].append(card)
            }
        }
        print(foundations)
    }

    func pop() {

    }

    func move() {
        
    }

    func reset() {
        
    }
}
