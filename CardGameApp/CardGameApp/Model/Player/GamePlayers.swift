//
//  GamePlayers.swift
//  CardGame
//
//  Created by 윤지영 on 22/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

class GamePlayers {
    private let players: [Player]
    private let dealer: Dealer

    init(numberOfPlayers: Int) {
        var players: [Player] = []
        for _ in 1...numberOfPlayers {
            players.append(Player())
        }
        self.players = players
        self.dealer = Dealer(with: CardDeck())
    }

    func resetCards() {
        for player in players {
            player.resetCards()
        }
        dealer.resetCards()
    }

    private func showResult(of result: (String, String) -> Void, screen clear: () -> ()) {
        clear()
        for index in players.indices {
            let name = "\(players[index].name)#\(index+1)"
            let cards = players[index].showCards()
            result(name, cards)
        }
        result(dealer.name, dealer.showCards())
        sleep(1)
    }

    func takeCard(visually cards: (String, String) -> Void, screen clear: () -> ()) -> Bool {
        var playersIncludingDealer: [GamePlayer] = players
        playersIncludingDealer.append(dealer)
        for player in playersIncludingDealer {
            guard let card = dealer.dealOut() else { return false }
            player.take(card: card)
            showResult(of: cards, screen: clear)
        }
        return true
    }

    private func pickWinnerAmongPlayers() -> (winner: Player, number: Int)? {
        guard var winner = players.first else { return nil }
        var number = 0
        for index in players.indices {
            guard let bestHandOfWinner = winner.bestHand else { continue }
            guard let bestHandOfPlayer = players[index].bestHand else { continue }
            if bestHandOfWinner < bestHandOfPlayer {
                winner = players[index]
                number = index
            }
        }
        return (winner, number)
    }

    private func dealerWin(over player: Player) -> Bool? {
        guard let bestHandOfDealer = dealer.bestHand else { return nil }
        guard let bestHandOfPlayer = player.bestHand else { return nil }
        return bestHandOfPlayer < bestHandOfDealer
    }

    func showName(of winner: (String) -> Void) {
        if let result = pickWinnerAmongPlayers() {
            guard let dealerWins = dealerWin(over: result.winner) else { return }
            if dealerWins {
                winner(dealer.name)
            } else {
                winner("\(result.winner.name)\(result.number+1)")
            }
            sleep(2)
        }
    }

    func hasEnoughCards(forNext gameMode: GameMode) -> Bool {
        return dealer.hasEnoughCards(for: players.count+1, in: gameMode)
    }

}
