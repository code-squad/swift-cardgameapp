//
//  Error.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 1. 9..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation

enum ErrorMessage : String, Error {
    case wrongCardInfo = "잘못된 카드정보입니다."
    case playDeckSettingFail = "플레이덱 세팅 실패"
    case notEnoughCardForPlayDeck = "플레이덱을 만들 카드가 부족합니다."
}
