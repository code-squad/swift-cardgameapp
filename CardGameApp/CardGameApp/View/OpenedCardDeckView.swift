//
//  OpenedCardDeckView.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 3. 6..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class OpenedCardDeckView: UIView {
    var images: [String] = [] {
        didSet {
            for i in stride(from: subviews.count-1, through: 0, by: -1) {
                subviews[i].removeFromSuperview()
            }
            if images.count == 0 {
                let emptyCardView = CardView(frame: getCardFrame())
                emptyCardView.layer.cornerRadius = CGFloat(Figure.Layer.cornerRadius.value)
                emptyCardView.layer.borderWidth = CGFloat(Figure.Layer.borderWidth.value)
                emptyCardView.layer.borderColor = UIColor.white.cgColor
                addSubview(emptyCardView)
            }
            for i in images.indices {
                let cardView = CardView(frame: getCardFrame())
                cardView.setImage(name: images[i])
                if images[i] != Figure.Image.back.value {
                    cardView.isUserInteractionEnabled = true
                }
                cardView.accessibilityIdentifier = images[i]
                addSubview(cardView)
            }
            setNeedsDisplay()
        }
    }

    func addNewCard(image: String) {
        images.append(image)
    }

    private func getCardFrame() -> CGRect {
        return CGRect(x: bounds.origin.x,
                      y: bounds.origin.y,
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
