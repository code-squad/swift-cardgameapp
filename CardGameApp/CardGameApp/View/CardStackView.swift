//
//  CardStackView.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 28..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

class CardStackView {
    var cardStack: CardStack? {
        willSet(newStack) {
            makeCardStackImageView(newStack)
        }
    }
    var cardStackImageViews: [UIImageView] = [UIImageView]()

    init() {}
    deinit {
        cardStack = nil
    }
}

extension CardStackView {
    func setCardStack(_ cardStack: CardStack) {
        self.cardStack = cardStack
    }

    func makeCardStackImageView(_ cardStack: CardStack?) {
        var imageViews = [UIImageView]()
        guard var stack = cardStack else {
            return
        }
        while stack.count > 1 {
            guard let card = stack.pop() else {
                break
            }
            imageViews.append(UIImageView(image: card.makeBackImage()))
        }
        guard let card = stack.pop() else {
            return
        }
        imageViews.append(UIImageView(image: card.makeImage()))
        cardStackImageViews = imageViews
    }
}
