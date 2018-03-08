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

    var images: [String?] = [] {
        didSet {
            for index in images.indices {
                if let targetView = subviews[index] as? UIImageView {
                    targetView.image = UIImage(named: images[index] ?? "")
                }
            }
            setNeedsDisplay()
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
        cardWidth = bounds.size.width / CGFloat(Figure.Count.foundations.value) - marginBetweenCards
    }

    private func configureFoundations() {
        for index in 0..<Figure.Count.foundations.value {
            addSubview(getFoundation(index: index))
        }
        spacing = UIStackView.spacingUseDefault
        distribution = .fillEqually
    }

    private func getFoundation(index: Int) -> UIImageView {
        let frameX = bounds.origin.x + marginBetweenCards + ((cardWidth + marginBetweenCards) * CGFloat(index))
        let cardFrame = CGRect(x: frameX, y: bounds.origin.y, width: cardWidth, height: cardHeight)
        let imageView = UIImageView(frame: cardFrame)
        imageView.layer.cornerRadius = CGFloat(Figure.Layer.cornerRadius.value)
        imageView.layer.borderWidth = CGFloat(Figure.Layer.borderWidth.value)
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }

    func reset() {
        subviews.forEach {
            if let subview = $0 as? UIImageView {
                subview.image = nil
            }
        }
    }
}
