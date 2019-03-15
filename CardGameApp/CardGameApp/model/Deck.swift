//
//  Deck.swift
//  CardGame
//
//  Created by Yoda Codd on 2018. 6. 20..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation
/// 카드들을 가지고 있는 구조체
class Deck {
    // 덱 선언
    private var cardList : [Card] = []
    
    // 이니셜라이저는 두종류
    init(){ }
    init(cardList: [Card]){
        self.cardList = cardList
    }
    
    /// 카드수 리턴
    func count() -> Int {
        return cardList.count
    }
    
    /// 카드 한장을 빼서 리턴
    func removeOne() -> Card? {
        // 카드가 있으면 마지막 팝, 없으면 닐 리턴
        return cardList.popLast()
    }
    
//    /// 카드를 섞는다
//    func shuffle(){
//        // 임시 덱 생성
//        var tempDeck : [Card] = []
//        // 카운트 프로퍼티 생성
//        var cardCount = count()
//        // 반복문으로 셔플을 시작한다
//        while cardCount > 0 {
//            // 0 ~ 카운트 까지중 랜덤수자를 생성한다
//            let randomNumberingNumber = Int(arc4random_uniform(UInt32(cardCount)))
//            // 덱의 렌덤위치를 임시덱으로 옮긴다. 이과정에서 기존덱의 항목은 빠진다.
//            tempDeck.append(self.cardList.remove(at: randomNumberingNumber))
//            // 작업이 끝나면 카운트를 줄인다
//            cardCount -= 1
//        }
//        // 기존덱을 셔플이 끝난 임시덱으로 바꾼다
//        cardList = tempDeck
//    }
    
    /// 임시용 셔플안함
    
    func shuffle(){
    }
    
    /// 덱 전체 카드를 정보로 표현
    func info() -> [CardInfo] {
        return cardList
    }
    
    /// 카드배열을 받아서 추가. 오픈덱 -> 덱
    func addCards(cards: [Card]){
        // 모든 카드가 대상
        for card in cards {
            // 이동 전의 과거카드데이터 생성
            let pastCardData = PastCardData(cardInfo: card)
            // 덱 타입 수정
            card.deckType = .deck
            card.deckLine = 0
            // 카드 추가
            cardList.append(card)
            // 카드가 추가되었음을 알리는 노티
            NotificationCenter.default.post(name: .cardMoved, object: pastCardData)
        }
    }
    
    /// 카드 전체 리턴기능
    func getAllCard() -> [Card] {
        return self.cardList
    }
    
    /// 덱 전체 리스트를 문자열로 리턴
    func getAllDeckCardName() -> String {
        // 결과용
        var result : String = "덱 카드 리스트 : "
        for card in cardList {
            result.append("\(card.name())\n")
        }
        return result
    }
}
