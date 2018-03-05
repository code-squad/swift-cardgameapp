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
            if images.count == 0 {
                let emptyCardView = CardView(frame: getCardFrame(yIndex: images.count))
                emptyCardView.layer.cornerRadius = CGFloat(Figure.Layer.cornerRadius.value)
                emptyCardView.layer.borderWidth = CGFloat(Figure.Layer.borderWidth.value)
                emptyCardView.layer.borderColor = UIColor.white.cgColor
                addSubview(emptyCardView)
            }
            for i in images.indices {
                let cardView = CardView(frame: getCardFrame(yIndex: i))
                cardView.setImage(name: images[i])
                if images[i] != Figure.Image.back.value {
                    cardView.isUserInteractionEnabled = true
                }
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
