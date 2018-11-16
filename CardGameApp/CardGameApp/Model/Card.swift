//
//  Card.swift
//  CardGame
//
//  Created by oingbong on 2018. 8. 22..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation
import UIKit

/*
 카드를 class로 선택한 이유는 카드의 개수는 number * shape 로 총 52개가 정해져있는데 값타입보다는 참조타입이 적합하다고 판단되어 사용하였습니다.
 의도에 맞게 class를 사용하였는지 잘 모르겠으나 추후 코드수정을 조금이나마 줄이기 위해 구조체 대신 선택하였습니다.
 */

class Card: CustomStringConvertible {
    private var cardNumber: CardNumber
    private var cardShape: CardShape
    private var condition: CardCondition
    
    init(number: CardNumber, shape: CardShape) {
        self.cardNumber = number
        self.cardShape = shape
        self.condition = .back
    }
    
    var description: String {
        return "\(self.cardShape.rawValue)\(self.cardNumber.rawValue)"
    }
    
    func isHighNumber(with anotherCard: Card) -> Bool {
        let result = self.cardNumber.hashValue > anotherCard.cardNumber.hashValue ? true : false
        return result
    }
    
    func image() -> UIImage? {
        if self.condition == .back {
            let image = "card-back".formatPNG
            return UIImage(named: image)
        }
        
        guard let shape = self.cardShape.rawValue.first else { return nil }
        let number = self.cardNumber.rawValue
        let cardName = String(shape) + number
        guard let cardImage = UIImage(named: cardName.formatPNG) else { return nil }
        return cardImage
    }
    
    func switchCondition(with condition: CardCondition) {
        self.condition = condition
    }
    
    func turnOver() -> UIImage? {
        self.condition = self.condition == CardCondition.back ? CardCondition.front : CardCondition.back
        return self.image()
    }
    
    func isFrontCondition() -> Bool {
        return self.condition == .front ? true : false
    }
    
    func isAce() -> Bool {
        return self.cardNumber == .ace
    }
    
    func isKing() -> Bool {
        return self.cardNumber == .king
    }
}

extension Card: Equatable, Comparable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.cardNumber == rhs.cardNumber
    }
    
    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.cardNumber.hashValue < rhs.cardNumber.hashValue
    }
    
    static func > (lhs: Card, rhs: Card) -> Bool {
        return lhs.cardNumber.hashValue > rhs.cardNumber.hashValue
    }
}
