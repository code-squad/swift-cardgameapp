//
//  Slot.swift
//  CardGame
//
//  Created by Yoda Codd on 2018. 6. 20..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

class Slot {
    // 카드배열 선언
    private var cardList : [Card]
    // 이니셜라이저
    init(_ cardList: [Card]){
        self.cardList = cardList
    }
    
    /// description 프로토콜을 준수한다
    var description : String {
        return getInfo()
    }
    
    /// 카드 카운트 리턴
    func count() -> Int {
        return cardList.count
    }
    
    func pop() -> Card? {
        return cardList.popLast()
    }
    
    
}
