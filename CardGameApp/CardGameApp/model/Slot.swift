//
//  Slot.swift
//  CardGame
//
//  Created by Yoda Codd on 2018. 6. 20..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

class Slot : CustomStringConvertible{
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
    
    /// 내용을 출력하는 함수
    func getInfo() -> String{
        // 카드가 없을경우 빈 배열모양을 리턴
        if cardList.count == 0 {
            return "[]"
        }
        // 리턴값 문자열로 변수 선언한다
        var result : String = "["
        // 반복문으로 결과값에 문자열을 쌓는다
        for card in cardList {
            result.append(card.getInfo()+",")
        }
        // 마지막 , 를 지워준다
        result.removeLast()
        // 결과에 ] 붙여 리턴한다
        return result+"]"
    }
}
