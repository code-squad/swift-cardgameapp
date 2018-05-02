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

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
    }

    convenience init() {
        self.init(frame: CGRect(x: 0, y: PositionY.bottom.value,
                                width: 414, height: 736 - PositionY.bottom.value))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func newDraw() {
        for i in 0...6 {
            let oneStack = OneStack(column: i)
            addSubview(oneStack)
            oneStack.drawCards()
        }
    }

}

class OneStack: UIView {
    var column: Int!
    var gameManager: CardGameManageable = CardGameDelegate.shared()
    var mystackManager: StackDelegate!

    var countOfCard: Int {
        return gameManager.countOfCards(column: self.column)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(column: Int) {
        self.init(frame: CGRect(x: PositionX.allValues[column].value,
                                y: 0,
                                width: 414 / 7,
                                height: 736 - PositionY.bottom.value))
        self.column = column
        self.mystackManager = self.gameManager.stackManagers[column]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func drawCards() {
        for i in 0..<countOfCard {
            let card = gameManager.cardInturn(at: (column: self.column, row: i))
            let newOrigin = CGPoint(x: 0, y: ViewController.spaceY * CGFloat(i))
            let frameForDraw = CGRect(origin: newOrigin, size: ViewController.cardSize)
            let cardImage = CardImageView(frame: frameForDraw)
            cardImage.getImage(of: card)
            addSubview(cardImage)
        }
    }
}

