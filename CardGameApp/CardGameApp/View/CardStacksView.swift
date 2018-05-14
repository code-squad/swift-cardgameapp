//
//  CardStacksView.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 19..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class CardStacksView: UIView {
    private var wholeStackManager: (CardStackDelegate & Stackable)!
    private var oneStackViews = [OneStack]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
    }

    convenience init() {
        self.init(frame: CGRect(x: 0, y: PositionY.bottom.value,
                                width: 414, height: 736 - PositionY.bottom.value))
        self.wholeStackManager = CardGameManager.shared().getWholeStackDelegate()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setup() {
        for i in 0...6 {
            oneStackViews.append(OneStack(column: i, manager: wholeStackManager))
            addSubview(oneStackViews[i])
            oneStackViews[i].setup()
        }
    }

    func reload(column: Int) {
        oneStackViews[column].reload()
    }

    func getOneStack(of column: Int) -> OneStack{
        return self.oneStackViews[column]
    }

}

class OneStack: UIView {
    private var column: Int!
    private var wholeStackManager: (CardStackDelegate & Stackable)!
    private var stackManager: StackDelegate!
    var lastCardView: CardImageView? {
        guard let lastView = subviews.last else { return nil }
        return lastView as? CardImageView
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(column: Int, manager: CardStackDelegate & Stackable) {
        self.init(frame: CGRect(x: PositionX.allValues[column].value,
                                y: 0,
                                width: 414 / 7,
                                height: 736 - PositionY.bottom.value))
        self.column = column
        self.wholeStackManager = manager
        self.stackManager = wholeStackManager.getStackDelegate(of: column)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        for i in 0..<stackManager.countOfCard() {
            let card = stackManager.cardInTurn(at: i)
            let newOrigin = CGPoint(x: 0, y: ViewController.spaceY * CGFloat(i))
            let frameForDraw = CGRect(origin: newOrigin, size: ViewController.cardSize)
            let cardImage = CardImageView(frame: frameForDraw)
            cardImage.getImage(of: card)
            if i == stackManager.countOfCard() - 1 {
                self.setDoubleTabToCard(to: cardImage)
            }
            addSubview(cardImage)
        }
    }

    func reload() {
        self.subviews.forEach{ $0.removeFromSuperview() }
        setup()
    }

    private func setDoubleTabToCard(to card: CardImageView) {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(cardDoubleTapped(sender:)))
        doubleTap.numberOfTapsRequired = 2
        card.addGestureRecognizer(doubleTap)
    }

    @objc func cardDoubleTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let oneStackView = sender.view?.superview as! OneStack
            NotificationCenter.default.post(name: .doubleTappedStack, object: self, userInfo: ["from": oneStackView])
        }
    }

    func getColumn() -> Int {
        return self.column
    }

}

