//
//  File.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 3. 19..
//  Copyright © 2018년 Napster. All rights reserved.
//

import Foundation

protocol CardGameMoveAble: PushAble, PopAble {
    func pickCard(xIndex: Int, yIndex: Int) -> Card
    func lastCard(xIndex: Int) -> Card?
}

protocol PushAble {
    func pushCard(card: Card, index: Int)
}

protocol PopAble {
    func popCard(xPoint: Int)
}
