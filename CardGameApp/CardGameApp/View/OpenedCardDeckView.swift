//
//  OpenedCardDeckView.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 3. 6..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class OpenedCardDeckView: UIView {

    var cardImages: CardImages = [] {
        didSet {
            if let openedCardDeck = subviews[0] as? CardStackView {
                openedCardDeck.images = cardImages
            }
            setNeedsDisplay()
            setNeedsLayout()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureOpenedCardDeck()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureOpenedCardDeck()
    }

    private func configureOpenedCardDeck() {
        let openedCardDeck = CardStackView(frame: getCardFrame())
        openedCardDeck.setStackStyle(to: .stack)
        addSubview(openedCardDeck)
        cardImages = []
    }

    private func getCardFrame() -> CGRect {
        return CGRect(x: bounds.origin.x,
                      y: bounds.origin.y + layer.borderWidth,
                      width: bounds.size.width,
                      height: bounds.size.height)
    }

    func reset() {
        cardImages = []
    }

}
