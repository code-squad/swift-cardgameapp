//
//  StudPokerGame.swift
//  CardGame
//
//  Created by 심 승민 on 2017. 12. 4..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

class StudPokerGame: Sequence {
    private var stud: Stud
    private var dealer: Dealer
    private var deck: Deck
    private var players: [Player]
    private(set) var hasBestHandWinner: Bool
    let start: Int
    var playerCount: Int {
        return self.players.count
    }
    // 포커게임 객체 및 플레이어 생성.
    init(_ stud: Stud, with numberOfPlayers: Int) {
        self.stud = stud
        self.deck = Deck()
        self.dealer = Dealer(with: self.deck)
        self.players = []
        // 플레이어들을 만들면서 id 부여.
        for id in 0..<numberOfPlayers {
            self.players.append(Player(id))
        }
        // 딜러 카드스택을 저장할 플레이어 생성.
        self.players.append(Player(nil))
        self.start = 0
        self.hasBestHandWinner = false
    }
    // 딜러 접근 함수.
    func callDealer() -> Dealer {
        return self.dealer
    }

    // 내부의 각 player에 접근.
    func makeIterator() -> ClassIteratorOf<Player> {
        return ClassIteratorOf(self.players)
    }

    // 내부의 각 player에 인덱스로 접근.
    subscript(index: Int) -> Iterator.Element? {
        guard index > -1 else { return nil }
        return self[index]
    }

    // 카드 부족한지 확인.
    func isLackOfCards() -> Bool {
        let cardDemands = self.players.count * self.stud.rawValue
        guard self.deck.count - cardDemands > 0 else { return true }
        return false
    }

    // 게임 셋팅 후 딜러에게 게임 진행 위임.
    func begin() throws {
        try self.dealer.introduce(players, stud)
    }

}

// 게임 종료 후.
extension StudPokerGame {
    // 모든 플레이어들이 가진 패의 랭크 배열 반환.
    private func gatherPlayersRanks() -> [(Player, PokerHands.HandRanks)] {
        var playerRanks: [(Player, PokerHands.HandRanks)] = []
        for player in players {
            // 카드를 분배받은 각 플레이어들의 랭크 저장하여 반환.
            playerRanks.append((player, player.stackRank))
        }
        return playerRanks
    }

    // 모든 플레이어들이 가진 탑카드 배열 반환.
    private func gatherTopCards() -> [(Player, Card)] {
        var topCards: [(Player, Card)] = []
        for player in players {
            // 카드를 분배받은 각 플레이어들의 랭크 저장하여 반환.
            topCards.append((player, player.topCard))
        }
        return topCards
    }

    // 플레이어들의 모든 패가 noPair인 경우, true 반환.
    private func isAllNoPair(in playerRanks: [(Player, PokerHands.HandRanks)]) -> Bool {
        // .noPair가 아닌 패만 필터링.
        let isNotNoPairs = playerRanks.filter { $0.1 != .noPair }
        // .noPair가 아닌 패가 1개도 없으면 true 반환.
        return (isNotNoPairs.count <= 0)
    }

    // 플레이어들의 모든 패가 같은 경우, true 반환.
    private func isAllHandsEqual(in playerRanks: [(Player, PokerHands.HandRanks)]) -> Bool {
        var isAllEqual = false
        _ = playerRanks.sorted {
            if $0.1.rank == $1.1.rank {
                isAllEqual = true
            } else {
                isAllEqual = false
            }
            return true
        }
        return isAllEqual
    }

    // 가장 좋은 패를 가진 플레이어 반환.
    private func whoHasBestHand(in playerRanks: [(Player, PokerHands.HandRanks)]) -> Player {
        let sortedCards = playerRanks.sorted { $0.1.rank < $1.1.rank }
        return sortedCards.last!.0
    }

    // 가장 높은 탑카드를 가진 플레이어 반환.
    private func whoHasBestTopCard(in cards: [(Player, Card)]) -> Player {
        let sortedCards = cards.sorted { $0.1 < $1.1 }
        return sortedCards.last!.0
    }

    // 승자 플레이어 반환.
    func chooseWinner() -> Player {
        let playerRanks = gatherPlayersRanks()
        // 모든 패가 noPair이거나 같은 경우, 가장 높은 탑카드를 가진 플레이어 반환.
        if isAllNoPair(in: playerRanks) || isAllHandsEqual(in: playerRanks) {
            hasBestHandWinner = false
            return whoHasBestTopCard(in: gatherTopCards())
        } else {
            hasBestHandWinner = true
            // 디폴트: 가장 높은 패를 가진 플레이어 반환.
            return whoHasBestHand(in: gatherPlayersRanks())
        }
    }
}

// 포커게임에 필요한 상수 및 열거형.
extension StudPokerGame {
    // 참가 플레이어 수 범위. (1~4명)
    static let participantMinimum = 1
    static let participantMaximum = 4
    // 스터드 종류.
    enum Stud: Int {
        case fiveCard = 5
        case sevenCard = 7
    }
    // 카드게임 관련 에러.
    enum Error: String, Swift.Error, CustomStringConvertible {
        case lackOfCards
        case inputValueIsNil
        var description: String {
            var errorMessage: String = ""
            switch self {
            case .lackOfCards: errorMessage = "덱에 카드가 없습니다."
            case .inputValueIsNil: errorMessage = "입력값이 없습니다."
            }
            return errorMessage
        }
    }
}
