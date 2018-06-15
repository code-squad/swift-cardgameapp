//
//  File+.swift
//  CardGame
//
//  Created by Jung seoung Yeo on 2018. 5. 20..
//  Copyright © 2018년 JK. All rights reserved.
//

// 숫자를 가지는 enum
enum Shape: String {
    // 특별한 카드
    case King, Queen, Jack, Ace
    // 숫자
    case two = "2", three = "3", four = "4", five = "5", six = "6", seven = "7", eight = "8", nine = "9", ten = "10"
    // 숫자를 출력하는 변수
    var description : String {
        switch self {
        case .King:
            return "K"
        case .Queen:
            return "Q"
        case .Jack:
            return "J"
        case .Ace:
            return "A"
        default:
            return self.rawValue
        }
    }
}
