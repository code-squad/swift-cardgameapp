//
//  FoundationView.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 23..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class FoundationView: UIView {
    private let gameManager: CardGameDelegate = CardGameManager.shared()
    private var foundationManager: FoundationDelegate!
    private let numberOfFoundation = 4

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 414, height: 100))
        self.foundationManager = gameManager.getFoundationDelegate()
    }

    func setup() {
        for i in 0..<numberOfFoundation {
            let newOrigin = CGPoint(x: PositionX.allValues[i].value, y: PositionY.upper.value)
            let frameForDraw = CGRect(origin: newOrigin, size: ViewController.cardSize)
            self.setEmptyDock(in: frameForDraw)
        }
    }

    private func setEmptyDock(in frameForDraw: CGRect) {
        let foundation = UIView(frame: frameForDraw)
        foundation.clipsToBounds = true
        foundation.layer.cornerRadius = 5.0
        foundation.layer.borderColor = UIColor.white.cgColor
        foundation.layer.borderWidth = 1.0
        addSubview(foundation)
    }

    func reload() {
        self.subviews.forEach({ $0.removeFromSuperview() })
        for i in FoundationManager.range {
            let newOrigin = CGPoint(x: PositionX.allValues[i].value, y: PositionY.upper.value)
            let frameForDraw = CGRect(origin: newOrigin, size: ViewController.cardSize)
            if foundationManager.countOfCards(of: i) == 0 {
                self.setEmptyDock(in: frameForDraw)
            } else {
                for card in foundationManager.cards(in: i) {
                    let cardImage = CardImageView(frame: frameForDraw)
                    cardImage.getImage(of: card)
                    addSubview(cardImage)
                }
            }
        }
    }

}
