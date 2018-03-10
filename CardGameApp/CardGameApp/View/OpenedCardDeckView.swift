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
        openedCardDeck.layer.cornerRadius = CGFloat(Figure.Layer.cornerRadius.value)
        openedCardDeck.layer.borderWidth = CGFloat(Figure.Layer.borderWidth.value)
        openedCardDeck.layer.borderColor = UIColor.white.cgColor
        openedCardDeck.setStackStyle(to: .stack)
        addSubview(openedCardDeck)
    }

    private func getCardFrame() -> CGRect {
        return CGRect(x: bounds.origin.x,
                      y: bounds.origin.y,
                      width: bounds.size.width,
                      height: bounds.size.height)
    }

    func reset() {
        cardImages = []
    }

}
