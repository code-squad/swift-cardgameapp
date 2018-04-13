//
//  GameController.swift
//  CardGame
//
//  Created by YOUTH on 2018. 1. 17..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct GameController {
    private (set) var studType: Int
    private (set) var numberOfPlayer: Int
    var cardDeck = CardDeck()
    let outputView = OutputView()
    let scoreChecker = ScoreChecker()

    enum InitError: Error, CustomStringConvertible {
        case quit
        case wrongMenu
        case wrongPlayerNumber

        var description: String {
            switch self {
            case .quit : return "<< 게임 종료 >>"
            case .wrongMenu : return "<< 메뉴를 잘못 입력하셨습니다. 게임 메뉴를 다시 선택해주세요. >>\n"
            case .wrongPlayerNumber : return "<< 잘못 입력하셨습니다. 참여할 인원 수를 다시 입력해주세요. >>\n"
            }
        }
    }

    /*
     상위 모듈에서 GameController객체를 init할떄
     게임을 진행할 수 없는 값이 들어오면
     진행이 되지 않도록 throws 설정
     */

    init(stud: GameInputView.CardStudMenu,
         numberOfPlayer: Int?) throws {
        // set card stud
        switch stud {
        case .one:
            self.studType = 7
        case .two:
            self.studType = 5
        case .quitGame:
            throw InitError.quit // 게임 종료 메시지
        case .wrongInput:
            throw InitError.wrongMenu // 잘못된 값 입력 메시지
        }

        // set numberOfPlayer
        guard let number = numberOfPlayer else {
            throw InitError.wrongPlayerNumber // 숫자가 없음
        }
        if number >= 0 && number <= 4 {
            self.numberOfPlayer = number
        } else {
            throw InitError.wrongPlayerNumber // 플레이어 수 오류
        }
    }

    private func makeStack(stud: Int) -> CardStack {
        let cards = cardDeck.makeCards(self.studType)
        let stack = cardDeck.makeStack(cards: cards)
        return stack
    }

    func playWithPause() {
        while true {
            var players = [Player]()
            if cardDeck.hasEnoughCards(numberOfNeeded: self.studType * (self.numberOfPlayer+1)) {
                for playerNumber in 0..<self.numberOfPlayer {
                    let stack = makeStack(stud: self.studType)
                    let player = Player(stack: stack,
                                        position: playerNumber+1,
                                        scoreChecker: ScoreChecker())
                    players.append(player) // [player]를만든다.
                }
                let dealerStack = makeStack(stud: self.studType)
                let dealer = Dealer(stack: dealerStack)
                let table = CardTable(players: players, dealer: dealer)
                OutputView().printCardsStackWithName(table)
                OutputView().showResultWithLoading(text: OutputView.ProgramDescription.loadingScore)
                let winner = table.winner()
                let result = ResultData(result: "\(winner.name)(이)가 이겼습니다. 점수는 \(winner.score)입니다.\n")
                outputView.showResult(text: result)
                outputView.showResult(text: cardDeck)
            } else {
                outputView.showResult(text: OutputView.ProgramDescription.lackOfCard)
                break
            }
        }
    }

}

