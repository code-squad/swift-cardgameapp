//
//  CardStackView.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 3. 2..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class CardStackView: UIView {
    private var style: Style = .stack

    enum Style {
        case stack
        case attach
    }

    var images: CardImages = [] {
        didSet {
            for index in stride(from: subviews.count-1, through: 0, by: -1) {
                subviews[index].removeFromSuperview()
            }
            if images.isEmpty {
                addSubview(CardView.makeEmptyCardView(frame: getCardFrame()))
            }
            setCardStack(images: images)
            setNeedsDisplay()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setStackStyle(to style: Style) {
        self.style = style
    }

    private func setCardStack(images: CardImages) {
        images.forEach { image in
            let newCard = CardView.makeNewCardView(frame: getCardFrame(), imageName: image)
            switch style {
            case .attach:
                addNew(cardView: newCard)
            case .stack:
                addNew(cardView: newCard)
            }
        }
    }

    private func getCardFrame() -> CGRect {
        return CGRect(x: bounds.origin.x,
                      y: bounds.origin.y,
                      width: bounds.size.width,
                      height: bounds.size.width * CGFloat(Figure.Size.ratio.value))
    }

    func addNew(cardView: CardView) {
        switch style {
        case .stack:
            stack(newCard: cardView)
        case .attach:
            attach(newCard: cardView)
        }
    }

    private func stack(newCard: CardView) {
        addSubview(newCard)
    }

    private func attach(newCard: CardView) {
        addSubview(newCard)
        newCard.frame.origin.y += CGFloat(Figure.YPosition.betweenCards.value)
    }

    func reset() {
        images = []
    }

}
