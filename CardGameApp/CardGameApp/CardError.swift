//
//  CardError.swift
//  CardGame
//
//  Created by oingbong on 2018. 8. 22..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

enum InputError: Error, CustomStringConvertible {
    case unknown
    case inputError
    case inputNil
    case inputRangeExceeded
    
    var description: String {
        switch self {
        case .unknown:
            return "알 수 없는 에러가 발생하였습니다."
        case .inputError:
            return "잘못 입력하셨습니다."
        case .inputNil:
            return "입력값이 비어있습니다."
        case .inputRangeExceeded:
            return "입력를 범위 초과하였습니다."
        }
    }
}

enum CardError: Error, CustomStringConvertible {
    case cardNotFound
    case unknown
    case noCardsRemaining
    
    var description: String {
        switch self {
        case .unknown:
            return "알 수 없는 에러가 발생하였습니다."
        case .cardNotFound:
            return "카드를 찾을 수 없습니다."
        case .noCardsRemaining:
            return "남아있는 카드가 없습니다."
        }
    }
}
