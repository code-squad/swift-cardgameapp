//
//  ViewController.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 12..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var deckView: CardDeckView!
    private var stackView: CardStacksView!
    private var foundationView: FoundationView!
    private var cardGameManager: CardGameManageable!

    private var cardMaker: CardFrameManageable!

    private var cardDeckView: CardImageView!

    static let widthDivider: CGFloat = 8
    static let cardHeightRatio: CGFloat = 1.27

    let foundationPositionY: CGFloat = PositionY.upper.value

    private var cardWidth: CGFloat {
        return self.view.frame.width / ViewController.widthDivider
    }

    private var cardSize: CGSize {
        return CGSize(width: self.cardWidth,
                      height: cardWidth * ViewController.cardHeightRatio)
    }

    private var spaceX: CGFloat {
        return cardWidth / ViewController.widthDivider
    }

    static let spaceY: CGFloat = 15.0

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialView()
    }

    private func initialView() {
        self.cardGameManager = CardGameDelegate()
        cardMaker = CardMaker(size: self.view.frame.size)
        self.newFoundation()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_pattern")!)

        self.newDeck()
        self.newStacks()
    }

    // MARK: InitialView Related

    private func newDeck() {
        self.deckView = CardDeckView(cardMaker: self.cardMaker, gameManager: cardGameManager)
        self.view.addSubview(deckView)
        deckView.drawDefault()
    }

    private func newFoundation() {
        self.foundationView = FoundationView(cardMaker: self.cardMaker)
        self.view.addSubview(foundationView)
        foundationView.drawDefault()
    }

    private func newStacks() {
        self.stackView = CardStacksView(stackManager: self.cardGameManager, cardMaker: self.cardMaker)
        self.view.addSubview(stackView)
        stackView.drawDefault()
    }

    // MARK: Tap Gesture Related

    private func setGestureToCardDeck() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(deckTapped(sender:)))
        self.cardDeckView.addGestureRecognizer(tap)
    }

    @objc func deckTapped(sender : UITapGestureRecognizer) {
        if sender.state == .ended {
            self.drawPickedCard()
        }
    }

    private func drawPickedCard() {
        if cardGameManager.countOfDeck() > 0 {
            self.pickCardFromDeck()
        } else {
            cardDeckView.getRefreshImage()
        }
    }

    private func pickCardFromDeck() {
        let upperRightCornerX = PositionX.sixth.value
        let upperRightCornerY = PositionY.upper.value
        let pickedCardView = CardImageView(frame: CGRect(origin: CGPoint(x: upperRightCornerX,
                                                                         y: upperRightCornerY),
                                                         size: self.cardSize))
        let pickedCard = cardGameManager.pickACard()
        pickedCard.turnOver()
        pickedCardView.getImage(of: pickedCard)
        self.view.addSubview(pickedCardView)
    }

    // MARK: Shake motion Related

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            view.subviews.forEach() { $0.removeFromSuperview() }
            cardGameManager = CardGameDelegate()
            self.initialView()
        }
    }


}


