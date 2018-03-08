//
//  CardStackView.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 3. 2..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class CardPileView: UIView {
    var images: [String] = [] {
        didSet {
            for index in stride(from: subviews.count-1, through: 0, by: -1) {
                subviews[index].removeFromSuperview()
            }
            if images.isEmpty {
                let emptyCardView = CardView.makeEmptyCardView(frame: getCardFrame(yIndex: images.count))
                addSubview(emptyCardView)
            }
            for index in images.indices {
                let cardView = CardView.makeNewCardView(frame: getCardFrame(yIndex: index), imageName: images[index])
                addSubview(cardView)
            }
            setNeedsDisplay()
        }
    }

    private func getCardFrame(yIndex: Int) -> CGRect {
        return CGRect(x: bounds.origin.x,
                      y: bounds.origin.y + CGFloat(yIndex * Figure.YPosition.betweenCards.value),
                      width: bounds.size.width,
                      height: bounds.size.width * CGFloat(Figure.Size.ratio.value))
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
