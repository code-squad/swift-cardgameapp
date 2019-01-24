//
//  CardGame.swift
//  CardGame
//
//  Created by 윤지영 on 16/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

class CardGame {
    private let gameMode: GameMode
    private let numberOfPlayers: Int
    private var gamePlayers: GamePlayers

    init(gameMode: GameMode, numberOfPlayers: Int) throws {
        self.gameMode = gameMode
        guard numberOfPlayers > 0 else { throw GameInputError.noPlayer }
        self.numberOfPlayers = numberOfPlayers
        self.gamePlayers = GamePlayers(numberOfPlayers: numberOfPlayers)
    }

    private func deal(visually cards: (String, String) -> Void, screen clear: () -> ()) -> Bool {
        for _ in 1...gameMode.numberOfCards {
            guard gamePlayers.takeCard(visually: cards, screen: clear) else { return false }
        }
        return true
    }

    func play(visually cards: (String, String) -> Void, screen clear: () -> (), ended winner: (String) -> Void) -> Bool {
        gamePlayers.resetCards()
        guard gamePlayers.hasEnoughCards(forNext: gameMode) else { return false }
        guard deal(visually: cards, screen: clear) else { return false }
        gamePlayers.showName(of: winner)
        return true
    }

}
