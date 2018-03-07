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
            for index in stride(from: subviews.count-1, through: 0, by: -1) {
                subviews[index].removeFromSuperview()
            }
            if images.isEmpty {
                let emptyCardView = CardView.makeEmptyCardView(frame: getCardFrame())
                addSubview(emptyCardView)
            }
            for index in images.indices {
                let cardView = CardView.makeNewCardView(frame: getCardFrame(),
                                                        imageName: images[index])
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
