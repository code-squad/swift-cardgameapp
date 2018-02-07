//
//  CardViewModel.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 7..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

class CardViewModel {
    private let card: Card
    private var isFaceUp: Bool
    private var frontImageName: String
    private var backImageName: String

    init(isFaceUp: Bool=false) {
        self.deck = Deck()
        self.shape.description + self.number.description
        Constants.ImageName.cardBack
    }

    func turnOver(_ faceToBeUp: Bool) {

    }
}
