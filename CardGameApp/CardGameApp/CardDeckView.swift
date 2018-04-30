//
//  CardDeckView.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 24..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class CardDeckView: UIView {
    var gameManager: CardGameManageable = CardGameDelegate.shared()
    var closedCardDeck = CardImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 414, height: 100))
    }

    func drawDefault() {
        let newOrigin = CGPoint(x: PositionX.seventh.value, y: PositionY.upper.value)
        let frameForDraw = CGRect(origin: newOrigin, size: ViewController.cardSize)
        self.closedCardDeck = CardImageView(frame: frameForDraw)
        self.setGestureToCardDeck()

        if gameManager.hasEnoughCard() {
            closedCardDeck.getDeckImage()
            addSubview(closedCardDeck)
        } else {
            closedCardDeck.getRefreshImage()
            addSubview(closedCardDeck)
        }
    }

    // MARK: Tap Gesture Related

    private func setGestureToCardDeck() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(deckTapped(sender:)))
        self.closedCardDeck.addGestureRecognizer(tap)
    }

    @objc func deckTapped(sender : UITapGestureRecognizer) {
        if sender.state == .ended {
            self.drawPickedCard()
        }
    }

    private func drawPickedCard() {
        if gameManager.hasEnoughCard() {
            self.pickCardFromDeck()
        } else {
            closedCardDeck.getRefreshImage()
        }
    }

    private func pickCardFromDeck() {

        let newOrigin = CGPoint(x: PositionX.sixth.value, y: PositionY.upper.value)
        let frameForDraw = CGRect(origin: newOrigin, size: ViewController.cardSize)

        let pickedCardView = CardImageView(frame: frameForDraw)
        let pickedCard = gameManager.pickACard()
        pickedCard.turnOver()
        pickedCardView.getImage(of: pickedCard)
        addSubview(pickedCardView)
    }

}
