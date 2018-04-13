//
//  CardTable.swift
//  CardGame
//
//  Created by YOUTH on 2018. 1. 21..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct CardTable {
    var players: [Player]
    var dealer: Dealer

    init(players: [Player], dealer: Dealer){
        self.players = players
        self.dealer = dealer
    }

    func stack() -> [CardStack] {
        var stackOfPlayers = [CardStack]()
        for player in players {
            stackOfPlayers.append(player.stack)
        }
        return stackOfPlayers
    }

    func winner() -> Player {
        var allPlayers = self.players
        allPlayers.append(self.dealer)
        let winner = allPlayers.max {a,b in a.score < b.score}
        guard let finalWinner = winner else {
            print("Can't find the winner")
            return self.dealer
        }
        return finalWinner
    }

}
