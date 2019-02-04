//
//  CardViewModel.swift
//  CardGameApp
//
//  Created by 윤지영 on 29/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import Foundation

class CardViewModel {
    private let card: Card
    private var opened: Bool

    required init(card: Card) {
        self.card = card
        self.opened = false
    }

    func flip() {
        opened.toggle()
    }

    var imageName: String {
        return opened ? "\(card)" : "card-back"
    }

}
