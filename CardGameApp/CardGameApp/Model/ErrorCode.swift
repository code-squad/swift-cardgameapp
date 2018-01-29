//
//  ErrorCode.swift
//  CardGame
//
//  Created by Mrlee on 2017. 12. 4..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

enum ErrorCode: String, Error {
    case invaildInput = "입력값을 확인해 주세요."
    case zeroCard = "마지막 카드를 다 쓰셨습니다! 새로운 덱을 가져오세요."
    case noGameNumbers = "지원하진 않는 게임 번호 입니다."
    case invaildPlayersNumber = "최소 참여인원은 1명이며 최대 참여인원은 4명입니다."
    case notDefineError = "알 수 없는 에러가 발생하였습니다."
}
