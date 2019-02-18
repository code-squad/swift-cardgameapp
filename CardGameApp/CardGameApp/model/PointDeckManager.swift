//
//  PointDeckManager.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 1. 25..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation

/// 포인트덱을 관리하는 객체
class PointDeckManager {
    //// 포인트덱 4개 소지
    private var pointDeckList : [PointDeck]
    
    /// 생성자
    init(){
        pointDeckList = []
        
        // 모든 마크 생성
        let allMarks = Mark.allCases()
        
        // 마크별로 추가
        for mark in allMarks {
            pointDeckList.append(PointDeck(mark: mark))
        }
    }
    
    /// 카드객체와 마크를 받아서 맞는 포인트덱에 카드 추가
    func addCard(card: Card) -> CardInfo? {
        // 모든 포인트덱이 대상
        for pointDeck in pointDeckList {
            // 추가성공시 추가된 카드 정보를 리턴
            if let addedCard = pointDeck.addCard(card: card) {
                return addedCard
            }
        }
        // 추가 실패시 닐리턴
        return nil
    }
}
