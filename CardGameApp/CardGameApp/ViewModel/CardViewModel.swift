//
//  CardViewModel.swift
//  CardGameApp
//
//  Created by 윤지영 on 29/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import Foundation

class CardViewModel {
    private var card: Card
    private var opened: Bool

    required init(card: Card) {
        self.card = card
        self.opened = false
    }

    func flip() {
        opened.toggle()
        NotificationCenter.default.post(name: .cardDidFlip, object: self)
    }

    var imageName: String {
        return opened ? "\(card)" : "card-back"
    }

    func replace(card: Card) {
        self.card = card
        NotificationCenter.default.post(name: .cardDidReset, object: self)
    }

}

extension NSNotification.Name {
    static let cardDidFlip = NSNotification.Name("cardDidFlip")
    static let cardDidReset = NSNotification.Name("cardDidReset")
}
