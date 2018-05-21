//
//  CardDeckView.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 24..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class CardDeckView: UIView, Movable {
    private var gameManager: CardGameDelegate = CardGameManager.shared()
    private var closedCardDeck = CardImageView()
    private var deckManager: CardDeckDelegate!
    var lastCardView: CardImageView? {
        guard let lastView = subviews.last else { return nil }
        return lastView as? CardImageView
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.frame = CGRect(x: 0, y: 0, width: ViewController.widthOfRootView, height: PositionY.bottom.value)
        self.isUserInteractionEnabled = true
    }

    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: ViewController.widthOfRootView, height: PositionY.bottom.value))
        self.deckManager = gameManager.getDeckDelegate()
    }

    func setup() {
        let newOrigin = CGPoint(x: PositionX.seventh.value, y: PositionY.upper.value)
        let frameForDraw = CGRect(origin: newOrigin, size: ViewController.cardSize)
        self.closedCardDeck = CardImageView(frame: frameForDraw)
        self.setTapGestureToCardDeck()
        if deckManager.hasEnoughCard() {
            closedCardDeck.getDeckImage()
            addSubview(closedCardDeck)
        } else {
            closedCardDeck.getRefreshImage()
            addSubview(closedCardDeck)
        }
    }

    // MARK: Tap Gesture Related

    private func setTapGestureToCardDeck() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(deckTapped(sender:)))
        self.closedCardDeck.addGestureRecognizer(tap)
    }

    @objc func deckTapped(sender : UITapGestureRecognizer) {
        if sender.state == .ended {
            NotificationCenter.default.post(name: .singleTappedClosedDeck, object: nil)
        }
    }

    func setOpenDeck() {
        let newOrigin = CGPoint(x: PositionX.sixth.value, y: PositionY.upper.value)
        let frameForDraw = CGRect(origin: newOrigin, size: ViewController.cardSize)

        let pickedCardView = CardImageView(frame: frameForDraw)
        self.setDoubleTabToCard(to: pickedCardView)

        guard let card = deckManager.lastOpenedCard() else { return }
        pickedCardView.getImage(of: card)
        addSubview(pickedCardView)
    }

    func loadRefreshIcon() {
        closedCardDeck.getRefreshImage()
    }

    private func setDoubleTabToCard(to card: CardImageView) {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(cardDoubleTapped(sender:)))
        doubleTap.numberOfTapsRequired = 2
        card.addGestureRecognizer(doubleTap)
    }

    @objc func cardDoubleTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let deckview = sender.view?.superview as! CardDeckView
            NotificationCenter.default.post(name: .doubleTappedOpenedDeck, object: self, userInfo: [Key.FromView: deckview])
        }
    }

    func reload() {
        self.subviews.forEach{ $0.removeFromSuperview() }
        setup()
        setOpenDeck()
    }

    func movableCardView() -> CardImageView {
        bringSubview(toFront: subviews.last!)
        return closedCardDeck
    }

    func resetByShake() {
        self.subviews.forEach{ $0.removeFromSuperview() }
        setup()
    }

    func cardImages(at: Int?) -> [CardImageView]? {
        guard let last = self.lastCardView else { return nil }
        return [last]
    }

    func convertViewKey() -> ViewKey {
        return .deck
    }

}
