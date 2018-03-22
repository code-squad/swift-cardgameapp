//
//  Foundation.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 3. 22..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

class Foundation: CardStack {
    func canPush(_ card: Card) -> Bool {
        if isEmpty {
            return (card.number == .ace)
        }
        return (card.number.rawValue == peek()!.number.rawValue+1) && (card.shape == peek()!.shape)
    }

}
