//
//  CardStacksView.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 19..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class CardStacksView: UIView {
    var stackManager: CardGameManageable = CardGameDelegate.shared()
    var cardMaker: CardFrameManageable?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
    }

    convenience init(cardMaker: CardFrameManageable) {
        self.init(frame: CGRect(x: 0, y: PositionY.bottom.value,
                                width: 414, height: 736 - PositionY.bottom.value))
        self.cardMaker = cardMaker
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func drawDefault() {
        guard let cardFrameMaker = self.cardMaker else { return }
        let countOfStacks = stackManager.countOfStacks()

        for i in 0..<countOfStacks {
            for j in 0...i {
                let card = stackManager.cardInturn(at: (column: i, row: j))
                let newY = ViewController.spaceY * CGFloat(j)

                let frameForDraw = cardFrameMaker.cardFrame(x: i, y: newY)

                let cardImage = CardImageView(frame: frameForDraw)
                cardImage.getImage(of: card)

                addSubview(cardImage)
            }
        }
    }

    func newDraw() {
        for i in 0...6 {
            let oneStack = OneStack(column: i, cardMaker: cardMaker!)
            addSubview(oneStack)
            oneStack.drawCards()
        }
    }

}

class OneStack: UIView {
    var column: Int!
    var stackManager: CardGameManageable = CardGameDelegate.shared()
    var cardMaker: CardFrameManageable!
    var countOfCard: Int {
        return stackManager.countOfCards(column: self.column)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(column: Int, cardMaker: CardFrameManageable) {
        self.init(frame: CGRect(x: PositionX.allValues[column].value,
                                y: PositionY.bottom.value,
                                width: 414 / 7,
                                height: 736 - PositionY.bottom.value))
        self.column = column
        self.cardMaker = cardMaker
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func drawCards() {
        for i in 0..<countOfCard {
            let card = stackManager.cardInturn(at: (column: self.column, row: i))
            let newY = ViewController.spaceY * CGFloat(i)

            let frameForDraw = cardMaker.cardFrame(x: self.column, y: newY)

            let cardImage = CardImageView(frame: frameForDraw)
            cardImage.getImage(of: card)

            addSubview(cardImage)
        }
    }
}

