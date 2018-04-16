//
//  ViewController.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 12..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let cardDeck = CardDeck()
    let widthDivider: CGFloat = 8
    let cardHeightRatio: CGFloat = 1.27
    let blankPositionY: CGFloat = 20
    let cardPositionY: CGFloat = 100
    let numberOfDeck = 7
    let numberOfFoundation = 4
    var cardDeckView = CardImageView()

    var cardWidth: CGFloat {
        return self.view.frame.width / widthDivider
    }

    var cardSize: CGSize {
        return CGSize(width: self.cardWidth,
                      height: cardWidth * cardHeightRatio)
    }

    var space: CGFloat {
        return cardWidth / 8
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = true
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_pattern")!)
        self.drawCards()
        self.drawFoundations()
        self.drawDeck()
        self.setGestureToCardDeckView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func drawCards() {
        cardDeck.shuffle()
        let cards = cardDeck.makeCards(numberOfDeck)
        for i in 0..<numberOfDeck {
            let cardX = (CGFloat(i+1)*space) + (CGFloat(i) * cardWidth)
            let cardImage = CardImageView()
            cardImage.getImage(of: cards[i])
            cardImage.frame = CGRect(origin: CGPoint(x: cardX, y: cardPositionY), size: self.cardSize)
            print(cardImage.frame)
            self.view.addSubview(cardImage)
        }
    }

    private func drawFoundations() {
        for i in 0..<numberOfFoundation {
            let cardX = (CGFloat(i+1)*space) + (CGFloat(i) * cardWidth)
            let foundation = UIView(frame: CGRect(origin: CGPoint(x: cardX, y: blankPositionY), size: self.cardSize))
            foundation.clipsToBounds = true
            foundation.layer.cornerRadius = 5.0
            foundation.layer.borderColor = UIColor.white.cgColor
            foundation.layer.borderWidth = 1.0
            self.view.addSubview(foundation)
        }
    }

    private func setGestureToCardDeckView() {
        cardDeckView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(deckTapped(sender:)))
        self.cardDeckView.addGestureRecognizer(tap)
    }

    @objc func deckTapped(sender : UITapGestureRecognizer) {
        if sender.state == .ended {
            self.drawTurnOverCard()
        }
    }

    private func drawTurnOverCard() {
        let upperRightCornerX = 297.5625
        let upperRightCornerY = 20.0
        let frontCardView = CardImageView(frame: CGRect(origin: CGPoint(x: upperRightCornerX, y: upperRightCornerY), size: self.cardSize))
        frontCardView.getImage(of: cardDeck.removeLast())
        self.view.addSubview(frontCardView)
    }

    private func drawDeck() {
        let upperRightCornerX = 355.78125
        let upperRightCornerY = 20.0
        cardDeckView = CardImageView(frame: CGRect(origin: CGPoint(x: upperRightCornerX, y: upperRightCornerY), size: self.cardSize))
        cardDeckView.getBackSide()
        self.view.addSubview(cardDeckView)
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            view.subviews.forEach() { $0.removeFromSuperview() }
            self.drawFoundations()
            self.drawDeck()
            self.drawCards()
        }
    }

}

