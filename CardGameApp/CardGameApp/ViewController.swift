//
//  ViewController.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 12..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var cardDeck: StackManageable!
    private var cardDeckView: CardImageView!
    private var stacksView = CardStacksView()

    let widthDivider: CGFloat = 8
    let cardHeightRatio: CGFloat = 1.27
    let numberOfFoundation = 4
    let foundationPositionY: CGFloat = PositionY.upper.value
    let cardPositionY: CGFloat = PositionY.bottom.value

    private var cardWidth: CGFloat {
        return self.view.frame.width / widthDivider
    }

    private var cardSize: CGSize {
        return CGSize(width: self.cardWidth,
                      height: cardWidth * cardHeightRatio)
    }

    private var spaceX: CGFloat {
        return cardWidth / widthDivider
    }

    private var spaceY: CGFloat = 15.0

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialView()
    }

    private func initialView() {
        self.cardDeck = CardStackDelegate()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_pattern")!)
        self.defaultStackImages()
        self.defaultDeck()
        self.drawFoundations()
        self.setGestureToCardDeck()
    }

    // MARK: InitialView Related

    private func defaultDeck() {
        cardDeckView = CardImageView(frame: CGRect(origin: CGPoint(x: PositionX.seventh.value,
                                                                   y: PositionY.upper.value),
                                                   size: self.cardSize))
        if cardDeck.countOfDeck() > 0 {
            cardDeckView.getBackSideImage()
            self.view.addSubview(cardDeckView)
        } else {
            cardDeckView.getRefreshImage()
            self.view.addSubview(cardDeckView)
        }
    }


    private func drawFoundations() {
        for i in 0..<numberOfFoundation {
            let cardX = (CGFloat(i+1)*spaceX) + (CGFloat(i) * cardWidth)
            let foundation = UIView(frame: CGRect(origin: CGPoint(x: cardX,
                                                                  y: foundationPositionY),
                                                  size: self.cardSize))
            foundation.clipsToBounds = true
            foundation.layer.cornerRadius = 5.0
            foundation.layer.borderColor = UIColor.white.cgColor
            foundation.layer.borderWidth = 1.0
            self.view.addSubview(foundation)
        }
    }

    private func defaultStackImages() {
        self.view.addSubview(stacksView)
        for i in 0..<CardStackDelegate.defaultStackNumber {
            for j in 0...i {
                let card = cardDeck.cardInturn(at: (column: i, row: j))

                let newY = cardPositionY + (spaceY * CGFloat(j))
                let frameForDraw = CGRect(origin: CGPoint(x: PositionX.allValues[i].value,
                                                     y: newY),
                                     size: self.cardSize)
                stacksView.draw(card: card, in: frameForDraw)
            }
        }
    }

    func stackImage(at: (columnI: Int, rowJ: Int)) -> Card {
        return cardDeck.cardInturn(at: (column: at.columnI, row: at.rowJ))
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
        if cardDeck.countOfDeck() > 0 {
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
        let pickedCard = cardDeck.pickACard()
        pickedCard.turnOver()
        pickedCardView.getImage(of: pickedCard)
        self.view.addSubview(pickedCardView)
    }

    // MARK: Shake motion Related

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            view.subviews.forEach() { $0.removeFromSuperview() }
            cardDeck = CardStackDelegate()
            self.initialView()
        }
    }


}


