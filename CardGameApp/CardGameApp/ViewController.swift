//
//  ViewController.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 12..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var cardDeck = CardDeck()
    let widthDivider: CGFloat = 8
    let cardHeightRatio: CGFloat = 1.27
    let foundationPositionY: CGFloat = 20
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
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_pattern")!)
        self.view.isUserInteractionEnabled = true
        self.initialView()
    }

    private func initialView() {
        self.drawStacks()
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

    // 카드뒷면출력
    private func drawCards() {
        cardDeck.shuffle()
        let cards = cardDeck.makeCards(numberOfDeck)
        for i in 0..<numberOfDeck {
            let cardX = (CGFloat(i+1)*space) + (CGFloat(i) * cardWidth)
            let cardImage = CardImageView()
            cardImage.getImage(of: cards[i])
            cardImage.frame = CGRect(origin: CGPoint(x: cardX, y: cardPositionY), size: self.cardSize)
            self.view.addSubview(cardImage)
        }
    }

    private func drawFoundations() {
        for i in 0..<numberOfFoundation {
            let cardX = (CGFloat(i+1)*space) + (CGFloat(i) * cardWidth)
            let foundation = UIView(frame: CGRect(origin: CGPoint(x: cardX, y: foundationPositionY), size: self.cardSize))
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
        print(self.cardDeck.description)
        if sender.state == .ended {
            self.drawPickedCard()
        }
    }

    private func makeStacks() -> [CardStack] {
        var stacks = [CardStack]()
        for i in 1...7 {
            let oneStack = cardDeck.makeStack(numberOf: i)
            stacks.append(oneStack)
        }
        for i in 0..<stacks.count {
            stacks[i].sortDefaultStack()
        }
        return stacks
    }

    private func drawStacks() {
        let locationX: [CGFloat] = [6.46875, 64.6875, 122.90625, 181.125, 239.34375, 297.5625, 355.78125]
        let stacks = self.makeStacks()
        for i in 0..<7 {
            for j in 0..<stacks[i].cards.count {
                let locationY = cardPositionY + (15 * CGFloat(j))
                let cardInStack = CardImageView(frame: CGRect(origin: CGPoint(x: locationX[i], y: locationY), size: self.cardSize))
                cardInStack.getImage(of: stacks[i].cards[j])
                self.view.addSubview(cardInStack)
            }
        }

    }

    // 카드앞면출력
    private func drawPickedCard() {
        let upperRightCornerX = 297.5625
        let upperRightCornerY = 20.0
        let frontCardView = CardImageView(frame: CGRect(origin: CGPoint(x: upperRightCornerX, y: upperRightCornerY), size: self.cardSize))
        let picked = cardDeck.removeLast()
        picked.turnOver()
        frontCardView.getImage(of: picked)
        self.view.addSubview(frontCardView)
    }

    private func drawDeck() {
        let upperRightCornerX = 355.78125
        let upperRightCornerY = 20.0
        cardDeckView = CardImageView(frame: CGRect(origin: CGPoint(x: upperRightCornerX, y: upperRightCornerY), size: self.cardSize))
        cardDeckView.getBackSideImage()
        self.view.addSubview(cardDeckView)
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            view.subviews.forEach() { $0.removeFromSuperview() }
            cardDeck = CardDeck()
            self.initialView()
        }
    }

}

