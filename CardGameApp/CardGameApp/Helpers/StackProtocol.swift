//
//  Stack.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 1. 31..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

// 카드게임스택 기능 제공.
protocol CardGameStack: Stack {
    func shuffle()

    func reset()
}

// 기본스택 기능 제공.
protocol Stack {
    var count: Int { get }
    var isEmpty: Bool { get }

    func push(card: Card)

    func pop() -> Card?

    func peek() -> Card?
}
