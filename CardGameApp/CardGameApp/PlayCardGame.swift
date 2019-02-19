//
//  PlayCardGame.swift
//  CardGame
//
//  Created by 윤동민 on 04/12/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct PlayCardGame {
    
    static func selectCard(menu: Int) {
        let cardCount: ChoiceMenu
        switch menu {
        case 0: cardCount = .sevenCard
        case 1: cardCount = .fiveCard
        default: return
        }
        Dealer.sharedInstance.setGameMenu(cardCount)
    }
    
    static func selectPlayer(menu: Int) {
        let playersCount: ChoiceParticipate
        switch menu {
        case 0: playersCount = .two
        case 1: playersCount = .three
        case 2: playersCount = .four
        default: return
        }
        Dealer.sharedInstance.setPlayersMenu(playersCount)
        Players.sharedInstance.makePlayer(by: playersCount, Dealer.sharedInstance)
    }

    static func judgeFourCard(of sortedCard: [Card]) -> Bool {
        for index in 0..<sortedCard.count-3 {
            if sortedCard[index].number == sortedCard[index+1].number && sortedCard[index+1].number == sortedCard[index+2].number && sortedCard[index+2].number == sortedCard[index+3].number { return true }
        }
        return false
    }
    
    static func judgeTripple(of sortedCard: [Card]) -> Bool {
        for index in 0..<sortedCard.count-2 {
            if sortedCard[index].number == sortedCard[index+1].number && sortedCard[index+1].number == sortedCard[index+2].number { return true }
        }
        return false
    }
    
    static func judgeTwoPair(of sortedCard: [Card]) -> Bool {
        var pairCount: Int = 0
        for index in 0..<sortedCard.count-1 {
            if sortedCard[index].number == sortedCard[index+1].number { pairCount += 1 }
        }
        if pairCount > 1 { return true }
        return false
    }
    
    static func judgeOnePair(of sortedCard: [Card]) -> Bool {
        for index in 0..<sortedCard.count-1 {
            if sortedCard[index].number == sortedCard[index+1].number { return true }
        }
        return false
    }
    
}
