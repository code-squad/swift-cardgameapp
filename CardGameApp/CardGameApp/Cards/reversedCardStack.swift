//
//  reversedCardsStack.swift
//  CardGameApp
//
//  Created by 윤동민 on 14/03/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation

extension NSNotification.Name {
    static let addReversedCard = NSNotification.Name("addReversedCard")
}

class ReversedCardStack: CardStack {
    override func add(_ card: Card) {
        super.add(card)
        NotificationCenter.default.post(name: .addReversedCard, object: nil, userInfo: ["card": card])
    }
}
