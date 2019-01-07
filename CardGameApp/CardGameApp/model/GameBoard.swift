//
//  GameBoard.swift
//  CardGame
//
//  Created by Yoda Codd on 2018. 6. 19..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation
/// 카드게임 진행을 하는 보드
class GameBoard {
    /// 덱 선언
    private var deck = Deck()
    /// 사용자가 오픈한 카드가 모이는 덱
    private var openedDeck : Deck = Deck()
    /// 점수를 얻는 칸
    private var pointCardSlot : [Card] = []
    /// 펼쳐놓는 카드들
    private var playCard : [[Card]] = []
    
    
    init(slotCount: Int){
        for _ in 1...slotCount {
            let emptyCardSlot : [Card] = []
            playCard.append(emptyCardSlot)
        }
        reset()
    }
    
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
    
    /// 게임을 초기화 한다
    func reset(){
        // 덱 초기화
        self.deck.reset()
        // 덱 섞기
        self.deck.shuffle()
        // 덱을 펼친다. 생성된 가로배열 만큼 반복
        setPlayCards()
    }
    
    /// 플레이카드 초기배치
    func setPlayCards(){
        // 덱을 펼친다. 생성된 가로배열 만큼 반복
        for x in 0..<playCard.count {
            // 1~ 가로배열 번호 만큼 카드를 추가
            for _ in 0...x {
                // 덱에서 카드 한장 뽑는다
                guard let popedCard = deck.removeOne() else { return () }
                // 뽑은 카드를 플레이배열에 넣는다
                playCard[x].addCard(popedCard)
            }
        }
    }
    
    /// 플레이카드 열번호로 카드정보 배열 리턴
    func getPlayCardLine(lineNumber: Int) -> [CardInfo] {
        return playCard[lineNumber-1]
    }
    
//    /// 슬롯 배열을 받아서 문자형 배열로 리턴
//    private func getInfo(slots: [Slot]) -> [String] {
//        // 결과 리턴용
//        var result : [String] = []
//
//        // 정보에 몇번 유저 슬롯인지 정보를 입력해준다.
//        for index in 1..<slots.count {
//            result.append("참가자#\(index) "+slots[index].getInfo())
//        }
//        // 딜러 결과를 리턴한다
//        result.append("딜러 "+slots[0].getInfo())
//        // 결과를 리턴한다
//        return result
//    }
    
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

/// 카드 배열의 경우를 위한 확장
extension Array where Element : Card{
    /// 카드배열에 카드 추가. 처음 추가할땐 앞면. 추가되면서 마지막을 뒷면처리. 따라서 마지막만 앞면 나머지는 뒷면
    mutating func addCard(_ newElement: Element) {
        // 배열에 카드가 있으면
        if let lastCard = last {
            // 마지막 카드를 뒤집는다.
            lastCard.flip()
        }
        // 마지막 추가카드를 뒤집는다
        newElement.flip()
        // 카드추가
        append(newElement)
    }
}
