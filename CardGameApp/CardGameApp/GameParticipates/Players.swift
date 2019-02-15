//
//  Players.swift
//  CardGame
//
//  Created by 윤동민 on 10/12/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol PlayersPrintable {
    func iterate(at playerNumber: Int, form: (String, [Card]) -> Void)
}

class Players {
    private var players: [GameParticipate] = []
    
    func makePlayer(by count: ChoiceParticipate, _ dealerPlayer: Dealer) {
        for playerNumber in 0..<count.rawValue {
            players.append(Player(name: "참가자#\(playerNumber+1)"))
        }
        players.append(dealerPlayer)
    }
    
    func countPlayers() -> Int {
        return players.count
    }
    
    func distributeCard(cardCount: Int, makeStack: (Int) -> [Card]) {
        for player in players { player.receiveCard(makeStack(cardCount)) }
    }
    
//    func judgePlayersState() {
//        let judgeLogic = {(cards: [Card]) -> CardRule in
//            let tempCard = cards.sorted(by: {$0.number.rawValue < $1.number.rawValue})
//            guard !PlayCardGame.judgeFourCard(of: tempCard) else { return .fourCard }
//            guard !PlayCardGame.judgeTripple(of: tempCard) else { return .tripple }
//            guard !PlayCardGame.judgeTwoPair(of: tempCard) else { return .twoPair }
//            guard !PlayCardGame.judgeOnePair(of: tempCard) else { return .onePair }
//            return .noPair
//        }
//
//        for player in players { player.judgeMyCard(method: judgeLogic) }
//    }
    
    func judgeWinner() -> String {
        var rankInPlayers = players.sorted(by: {$0 > $1})
        let candidate = rankInPlayers.filter { $0 == rankInPlayers[0] }
        if candidate.count != 1 { return highCardNumberSearch(in: candidate) }
        return rankInPlayers[0].name
    }
    
    private func highCardNumberSearch(in searchList: [GameParticipate]) -> String {
        var highCardOwner = searchList[0]
        for player in searchList {
            if highCardOwner.searchHighNumberCard() < player.searchHighNumberCard() { highCardOwner = player }
        }
        return highCardOwner.name
    }
}

extension Players: PlayersPrintable {
    func iterate(at number: Int, form: (String, [Card]) -> Void) {
        form(players[number].name, players[number].cards)
    }
}
