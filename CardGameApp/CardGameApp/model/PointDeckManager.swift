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
    
    /// 카드정보를 받아서 추가 가능한지 체크
    func checkAdd(cardInfo: CardInfo) -> Bool {
        // 모든 덱을 체크
        for pointDeck in pointDeckList {
            // 추가가능 하다면 참
            if pointDeck.checkAdd(cardInfo: cardInfo) {
                return true
            }
        }
        
        // 추가가능한 덱이 없다면 거짓
        return false
    }
    
    /// 카드객체를 알맞는 곳에 추가
    
    
    
}
