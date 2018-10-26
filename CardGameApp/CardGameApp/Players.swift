//
//  Players.swift
//  CardGame
//
//  Created by oingbong on 2018. 9. 9..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

class Players {
    private var players: [Player]
    
    init?(_ numberOfPlayers: NumberOfPlayers, _ gameType: GameType, _ cardDeck: CardDeck) {
        var players = [Player]()
        for number in 0..<numberOfPlayers.rawValue {
            guard let cards = cardDeck.remove(count: gameType.number) else { return nil }
            players.append(Player.init(cards, "참가자#\(number + 1)"))
        }
        guard let cards = cardDeck.remove(count: gameType.number) else { return nil }
        players.append(Player.init(cards, "딜러"))
        
        self.players = players
    }
    
    func printPlayersCards(_ handler: (Player) -> Void) {
        for index in 0..<self.players.count {
            handler(self.players[index])
        }
    }
    
    func printWinner(_ handler: (Player) -> Void) {
        // 핸즈 비교
        var winnerPlayer = playerWithHighHand()
        
        // 숫자 비교 : highHandPlayer 의 핸즈가 nothing 이면 마지막 숫자가 가장 큰게 우승
        if winnerPlayer.hands().0 == Hands.nothing {
            winnerPlayer = playerWithHighNumber()
        }
        
        handler(winnerPlayer)
    }
    
    private func playerWithHighHand() -> Player {
        var highPlayer = self.players[0]
        for player in self.players {
            let (highHands, highCard)  = highPlayer.hands()
            let (hands, card) = player.hands()
            
            if highHands < hands {
                highPlayer = player
            } else if highHands == hands {
                // 핸즈가 동일하면 숫자가 큰게 highPlayer
                highPlayer = highCard.isHighNumber(with: card) ? highPlayer : player
            }
        }
        return highPlayer
    }
    
    // 숫자가 같으면 앞 순번 참가자가 이기는 것으로 구성
    private func playerWithHighNumber() -> Player {
        var highPlayer = self.players[0]
        var highCard = self.players[0].findLargestNumber()
        
        for player in self.players {
            if player.findLargestNumber().isHighNumber(with: highCard) {
                highCard = player.findLargestNumber()
                highPlayer = player
            }
        }
        return highPlayer
    }
}
