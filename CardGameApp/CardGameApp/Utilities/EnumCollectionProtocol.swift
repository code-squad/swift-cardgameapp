//
//  EnumCollection.swift
//  CardGame
//
//  Created by 심 승민 on 2017. 11. 28..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

// EnumCollection을 채택한 타입은 Hashable도 구현해야 함. Enum은 이미 Hashable이므로 hashValue를 따로 구현해줄 필요 없음.
protocol EnumCollection: Hashable {
    // 자기자신 내부 요소로 sequence 만들어 반환.
    static func cases() -> AnySequence<Self>
    // sequence를 array로 타입캐스팅하여 반환.
    static var allValues: [Self] { get }
}
