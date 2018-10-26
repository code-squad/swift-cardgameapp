//
//  Game.swift
//  CardGame
//
//  Created by oingbong on 2018. 8. 27..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

protocol GamePrintable {
    func printPlayerCards(_ handler: (Player) -> Void)
    func printWinner(_ handler: (Player) -> Void)
}

class Game: GamePrintable {
    private var gameType: GameType
    private var numberOfPlayers: NumberOfPlayers
    private var players: Players?
    
    init?(_ type: GameType, _ numberOfPlayers: NumberOfPlayers, _ cardDeck: CardDeck) {
        self.gameType = type
        self.numberOfPlayers = numberOfPlayers
        guard let players = Players.init(self.numberOfPlayers, self.gameType, cardDeck) else { return nil }
        self.players = players
    }
    
    func printPlayerCards(_ handler: (Player) -> Void) {
        self.players?.printPlayersCards(handler)
    }
    
    func printWinner(_ handler: (Player) -> Void) {
        self.players?.printWinner(handler)
    }
    
}
