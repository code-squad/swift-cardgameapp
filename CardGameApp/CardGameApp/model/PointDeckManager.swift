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
    
    /// 카드객체를 알맞는 곳에 추가
    func addCard(card: Card) {
        // 추가 가능한 곳이 있어야 한다
        guard let checkedMark = checkAdd(card: card) else {
            // 추가 불가능
            return ()
        }
        
        // 확인된 마크로 카드를 추가해준다
        addCard(card: card, mark: checkedMark)
    }
    
    /// 카드정보를 받아서 추가 가능한지 체크
    private func checkAdd(card: Card) -> Mark? {
        // 모든 덱을 체크
        for pointDeck in pointDeckList {
            // 추가가능 하다면 해당 마크 리턴
            if pointDeck.checkAdd(card: card) {
                return pointDeck.mark
            }
        }
        
        // 추가가능한 덱이 없다면 닐 리턴
        return nil
    }
    
    /// 카드객체와 마크를 받아서 맞는 포인트덱에 카드 추가
    private func addCard(card: Card, mark: Mark) {
        // 모든 포인트덱이 대상
        for pointDeck in pointDeckList {
            // 마크가 일치하면
            if pointDeck.mark == mark {
                // 추가 후 바로 리턴
                pointDeck.addCard(card: card)
                return ()
            }
        }
    }
}
