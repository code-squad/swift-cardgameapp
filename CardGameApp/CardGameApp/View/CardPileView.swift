//
//  CardStackView.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 3. 2..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class CardPileView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func push(cardView: UIImageView, isSpread: Bool) {
        guard let baseCard = subviews.last else {
            self.addSubview(cardView)
            cardView.isUserInteractionEnabled = true
            return
        }
        baseCard.isUserInteractionEnabled = false
        self.addSubview(cardView)
        if isSpread {
            cardView.alignmentRect(forFrame: getNewCardPosition(baseCard: baseCard as! UIImageView))
        }
    }

    func pop() {
        self.subviews.last?.removeFromSuperview()
    }

    private func getNewCardPosition(baseCard: UIImageView) -> CGRect {
        return CGRect(x: baseCard.frame.origin.x,
                      y: baseCard.frame.origin.y + CGFloat(Figure.YPosition.betweenCards.value),
                      width: baseCard.frame.width,
                      height: baseCard.frame.height)
    }
}
