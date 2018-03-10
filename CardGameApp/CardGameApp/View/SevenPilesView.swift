//
//  CardPileView.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 1. 30..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class SevenPilesView: UIStackView {
    private var cardPileWidth: CGFloat!
    private var marginBetweenCards = CGFloat(Figure.Size.xGap.value)

    var imagesPack: [CardImages] = [] {
        didSet {
            for index in imagesPack.indices {
                if let foundation = subviews[index] as? CardStackView {
                    foundation.images = imagesPack[index]
                }
            }
            setNeedsDisplay()
            setNeedsLayout()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setCardPileSize()
        configureSevenPiles()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setCardPileSize()
        configureSevenPiles()
    }

    private func setCardPileSize() {
        cardPileWidth = bounds.size.width / CGFloat(Figure.Count.cardPiles.value) - marginBetweenCards
    }

    private func configureSevenPiles() {
        for index in 0..<Figure.Count.cardPiles.value {
            addSubview(configureCardPile(index: index))
        }
        spacing = UIStackView.spacingUseDefault
        distribution = .fillEqually
    }

    private func configureCardPile(index: Int) -> CardStackView {
        let frameX = marginBetweenCards + ((cardPileWidth + marginBetweenCards) * CGFloat(index))
        let cardFrame = CGRect(x: frameX, y: bounds.origin.y, width: cardPileWidth, height: bounds.size.height)
        let cardPile = CardStackView(frame: cardFrame)
        cardPile.setStackStyle(to: .attach)
        return cardPile
    }

    func reset() {
        for index in imagesPack.indices {
            imagesPack[index] = []
        }
    }
}
