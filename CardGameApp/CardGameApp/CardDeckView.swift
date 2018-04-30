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
    var cardMaker: CardFrameManageable?
    var closedCardDeck = CardImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    convenience init(cardMaker: CardFrameManageable) {
        self.init(frame: CGRect(x: 0, y: 0, width: 414, height: 100))
        self.cardMaker = cardMaker
    }

    func drawDefault() {
        //guard let cardDeck = self.gameManager else { return }
        guard let cardFrameMaker = self.cardMaker else { return }

        let deckButtonFrame = cardFrameMaker.cardFrame(x: 6, y: PositionY.upper.value)
        self.closedCardDeck = CardImageView(frame: deckButtonFrame)
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
//        guard let cardDeck = self.gameManager else { return }
        if gameManager.hasEnoughCard() {
            self.pickCardFromDeck()
        } else {
            closedCardDeck.getRefreshImage()
        }
    }

    private func pickCardFromDeck() {
        guard let cardFrameMaker = self.cardMaker else { return }
//        guard let cardDeck = self.gameManager else { return }

        let pickedCardFrame = cardFrameMaker.cardFrame(x: 5, y: PositionY.upper.value)

        let pickedCardView = CardImageView(frame: pickedCardFrame)
        let pickedCard = gameManager.pickACard()
        pickedCard.turnOver()
        pickedCardView.getImage(of: pickedCard)
        addSubview(pickedCardView)
    }

}
