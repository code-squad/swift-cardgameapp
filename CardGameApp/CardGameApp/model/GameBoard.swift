//
//  GameBoard.swift
//  CardGame
//
//  Created by Yoda Codd on 2018. 6. 19..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation
/// 카드게임 진행을 하는 보드
struct GameBoard {
    /// 랜덤한 카드 한장을 리턴한다
    func makeRandomCard() -> Card? {
        // 랜덤정수 생성
        let randomMarkNumber = String(Int(arc4random_uniform(4)+1))
        let randomNumberingNumber = String(Int(arc4random_uniform(13) + 1))
        
        // 카드용 마크,숫자 생성. 생성 실패리 닐 리턴
        guard let randomMark = Mark(rawValue: randomMarkNumber),
            let randomNumbering = Numbering(rawValue: randomNumberingNumber) else { return nil }
        
        // 카드 리턴
        return Card(mark: randomMark, numbering: randomNumbering)
    }
    
//    /// 게임종류,인원수와 카드배열을 받아서 딜러,플레이어의 슬롯배열을 리턴
//    private mutating func makeSlots(gameMode: GameMode, playerNumber: Int) -> [Slot]? {
//        // slot 배열을 만든다. 인덱스 0 이 딜러, 이후 인덱스가 플레이어
//        var slotList : [Slot] = []
//        // 플레이어수 + 1 만큼 반복
//        for _ in 0...playerNumber {
//            // 게임 종류별로 필요한 만큼 카드를 뽑느다
//            guard let pickedCards = deck.removeCards(gameMode.rawValue) else {
//                // 카드가 다 떨어지면 게임을 종료한다
//                return nil
//            }
//            // 뽑은 카드를 슬롯 리스트에 넣는다
//            slotList.append(pickedCards)
//        }
//        return slotList
//    }
    
    /// 슬롯 배열을 받아서 문자형 배열로 리턴
    private func getInfo(slots: [Slot]) -> [String] {
        // 결과 리턴용
        var result : [String] = []
        
        // 정보에 몇번 유저 슬롯인지 정보를 입력해준다.
        for index in 1..<slots.count {
            result.append("참가자#\(index) "+slots[index].getInfo())
        }
        // 딜러 결과를 리턴한다
        result.append("딜러 "+slots[0].getInfo())
        // 결과를 리턴한다
        return result
    }
    
    /// 덱 선언
    private var deck = Deck()
    
//    /// 게임모드,인원 을 받아서 게임결과를 문자형 배열로 리턴
//    mutating func startCardGame(gameMode: GameMode, playerNumber: Int) -> [String]? {
//        // 덱을 리셋하고 섞는다
//        deck.reset()
//        deck.shuffle()
//        // 슬롯 배열을 만든다. 카드가 다 떨어지면 닐 리턴
//        guard let slots = makeSlots(gameMode: gameMode, playerNumber: playerNumber) else {
//            return nil
//        }
//        return getInfo(slots: slots)
//    }
}
