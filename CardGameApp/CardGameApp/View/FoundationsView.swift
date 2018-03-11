//
//  FoundationViews.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 1. 30..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class FoundationsView: UIStackView {
    private var cardWidth: CGFloat!
    private var cardHeight: CGFloat {
        return cardWidth * CGFloat(Figure.Size.ratio.value)
    }
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
        setCardSize()
        configureFoundations()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setCardSize()
        configureFoundations()
    }

    private func setCardSize() {
        cardWidth = bounds.size.width
            / CGFloat(Figure.Count.foundations.value)
            - marginBetweenCards
    }

    private func configureFoundations() {
        for index in 0..<Figure.Count.foundations.value {
            addSubview(configureFoundation(index: index))
        }
        spacing = UIStackView.spacingUseDefault
        distribution = .fillEqually
    }

    private func configureFoundation(index: Int) -> CardStackView {
        let frameX = marginBetweenCards + ((cardWidth + marginBetweenCards) * CGFloat(index))
        let cardFrame = CGRect(x: frameX, y: bounds.origin.y,
                               width: cardWidth, height: cardHeight)
        let foundation = CardStackView(frame: cardFrame)
        foundation.setStackStyle(to: .stack)
        return foundation
    }

    func reset() {
        for index in imagesPack.indices {
            imagesPack[index] = []
        }
    }
}
