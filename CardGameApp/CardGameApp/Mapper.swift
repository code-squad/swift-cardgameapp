//
//  Mapper.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 7..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

class Mapper {
    static func mapFrontImageName(of card: Card) -> String {
        return Mapper.shapeName(of: card.info.shape) + Mapper.numberName(of: card.info.number)
    }

    private static func numberName(of number: Number) -> String {
        return String(number.rawValue)
    }

    private static func shapeName(of shape: Shape) -> String {
        var shapeName = ""
        switch shape {
        case .clubs: shapeName = "c"
        case .diamonds: shapeName = "d"
        case .hearts: shapeName = "h"
        case .spades: shapeName = "s"
        }
        return shapeName
    }
}
