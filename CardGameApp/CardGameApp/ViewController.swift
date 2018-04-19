//
//  ViewController.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 12..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var cardDeck = CardDeck()
    private var cardDeckView: CardImageView!

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
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_pattern")!)
        let cardStacksView = CardStacksView(stackImages: self.makeDefaultStackImages())
        self.view.addSubview(cardStacksView)
        self.defaultDeck()
        self.drawFoundations()
        self.setGestureToCardDeck()
    }

    // MARK: InitialView Related

    private func defaultDeck() {
        cardDeckView = CardImageView(frame: CGRect(origin: CGPoint(x: PositionX.seventh.value,
                                                                   y: PositionY.upper.value),
                                                   size: self.cardSize))
        if cardDeck.count() > 0 {
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

    private func makeStacks() -> [CardStack] {
        var stacks = [CardStack]()
        let defaultStackRange: CountableClosedRange = 1...7
        for i in defaultStackRange {
            let oneStack = cardDeck.makeStack(numberOf: i)
            stacks.append(oneStack)
        }
        return stacks
    }

    private func makeDefaultStackImages() -> [[CardImageView]] {
        let stacks = self.makeStacks()
        var stackImages = [[CardImageView]]()
        for i in 0..<stacks.count {
            stacks[i].sortDefaultStack()
            var oneStack = [CardImageView]()
            for j in 0..<stacks[i].count() {
                let locationY = cardPositionY + (spaceY * CGFloat(j))
                let cardInStack = CardImageView(frame: CGRect(origin: CGPoint(x: PositionX.allValues[i].value,
                                                                              y: locationY),
                                                              size: self.cardSize))
                cardInStack.getImage(of: stacks[i].getCard(at: j))
                oneStack.append(cardInStack)
            }
            stackImages.append(oneStack)
        }
        return stackImages
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
        if cardDeck.count() > 0 {
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
        let pickedCard = cardDeck.removeOne()
        pickedCard.turnOver()
        pickedCardView.getImage(of: pickedCard)
        self.view.addSubview(pickedCardView)
    }

    // MARK: Shake motion Related

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            view.subviews.forEach() { $0.removeFromSuperview() }
            cardDeck = CardDeck()
            self.initialView()
        }
    }


}


