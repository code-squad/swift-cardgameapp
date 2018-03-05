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
            for i in stride(from: subviews.count-1, through: 0, by: -1) {
                subviews[i].removeFromSuperview()
            }
            for i in images.indices {
                let cardFrame = CGRect(x: bounds.origin.x,
                                       y: bounds.origin.y + CGFloat(i * Figure.YPosition.betweenCards.value),
                                       width: bounds.size.width,
                                       height: bounds.size.width * CGFloat(Figure.Size.ratio.value))
                let cardView = CardView(frame: cardFrame)
                addSubview(cardView)
                cardView.setImage(name: images[i])
            }
            setNeedsDisplay()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setCardFigure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setCardFigure()
    }

    func setCardFigure() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
    }

    // 애니메이션을 위해 삭제 보류
//    func push(cardView: UIImageView, isSpread: Bool) {
//        guard let baseCard = subviews.last else {
//            addSubview(cardView)
//            cardView.isUserInteractionEnabled = true
//            return
//        }
//        baseCard.isUserInteractionEnabled = false
//        addSubview(cardView)
//        if isSpread {
//            cardView.alignmentRect(forFrame: getNewCardPosition(baseCard: baseCard as! UIImageView))
//        }
//    }
//
//    func pop() {
//        self.subviews.last?.removeFromSuperview()
//    }

}
