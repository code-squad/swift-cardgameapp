//
//  CardPileView.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 1. 30..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class SevenPilesView: UIStackView {
    var images: [[String]] = [] {
        didSet {
            for i in images.indices {
                (subviews[i] as? CardPileView)?.images = images[i]
            }
            setNeedsDisplay()
            setNeedsLayout()
        }
    }

    private var cardPileWidth: CGFloat!
    private var cardPileHeight: CGFloat {
        return cardPileWidth * CGFloat(Figure.Size.ratio.value)
    }
    private var marginBetweenCards = CGFloat(Figure.Size.xGap.value)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setCardPileSize()
        configureFoundations()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setCardPileSize()
        configureFoundations()
    }

    private func setCardPileSize() {
        cardPileWidth = bounds.size.width / CGFloat(Figure.Count.cardPiles.value) - marginBetweenCards
    }

    private func configureFoundations() {
        for i in 0..<Figure.Count.cardPiles.value {
            addSubview(getCardPile(index: i))
        }
        spacing = UIStackView.spacingUseDefault
        distribution = .fillEqually
    }

    private func getCardPile(index: Int) -> UIView {
        let cardPileFrame = CGRect(x: bounds.origin.x + marginBetweenCards + ((cardPileWidth + marginBetweenCards) * CGFloat(index)),
                                    y: bounds.origin.y,
                                    width: cardPileWidth,
                                    height: bounds.size.height)
        let cardPileView = CardPileView(frame: cardPileFrame)
        return cardPileView
    }
}
