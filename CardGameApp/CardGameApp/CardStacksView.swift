//
//  CardStacksView.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 19..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class CardStacksView: UIView {

    var stackManager: CardGameManageable? // CardGameDelegate
    var cardMaker: CardFrameManageable?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
    }

    convenience init(stackManager: CardGameManageable, cardMaker: CardFrameManageable) {
        self.init(frame: CGRect(x: 0, y: PositionY.bottom.value,
                                width: 414, height: 736 - PositionY.bottom.value))
        self.stackManager = stackManager
        self.cardMaker = cardMaker
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func draw(card: ImageSelector, in frame: CGRect) {
        let cardImage = CardImageView(frame: frame)
        cardImage.getImage(of: card)
        addSubview(cardImage)
    }

    func drawDefault() {
        guard let stacks = self.stackManager else { return }
        guard let cardFrameMaker = self.cardMaker else { return }
        let countOfStacks = stacks.countOfStacks()

        for i in 0..<countOfStacks {
            for j in 0...i {
                let card = stacks.cardInturn(at: (column: i, row: j))
                let newY = ViewController.spaceY * CGFloat(j)

                let frameForDraw = cardFrameMaker.cardFrame(x: i, y: newY)

                let cardImage = CardImageView(frame: frameForDraw)
                cardImage.getImage(of: card)

                addSubview(cardImage)
            }
        }
    }

}
