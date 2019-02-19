//
//  Space.swift
//  CardGame
//
//  Created by 윤동민 on 04/12/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

class Card {
    private(set) var shape : CardShape
    private(set) var number : CardNumber
    
    init(_ shape : CardShape, _ number : CardNumber) {
        self.shape = shape
        self.number = number
    }
}

// CustomStringConvertible 프로토콜 채택 -> 인스턴스의 고유 String 표현법으로 만들 수 있다.
extension Card : CustomStringConvertible {
    var description: String {
        return "\(shape)\(number)"
    }
}
