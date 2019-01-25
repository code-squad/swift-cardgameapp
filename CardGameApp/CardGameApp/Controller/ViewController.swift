//
//  ViewController.swift
//  CardGameApp
//
//  Created by 윤지영 on 22/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var cardImages: [CardImageView]!
    private var cardDeckImage: CardImageView!
    private var cardDeck: CardDeck

    required init?(coder aDecoder: NSCoder) {
        cardDeck = CardDeck()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        addCardImageViews()
        addEmptyCardImageViews()
        setCardDeckImage()
    }

    private func setBackground() {
        guard let image = UIImage(named: "bg_pattern.png") else { return }
        self.view.backgroundColor = UIColor(patternImage: image)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func setCardDeckImage() {
        guard let cards = cardDeck.removeMultiple(by: 1) else { return }
        let cardImageViewCreater = CardImageViewCreater(cards: cards, sideMargin: 5, topMargin: 20)
        let cardImageViews = cardImageViewCreater.createFewHorizontally(within: self.view.frame.width, divided: 7, align: .right)
        cardImageViews.forEach { self.view.addSubview($0) }
    }

    private func addEmptyCardImageViews() {
        guard let cards = cardDeck.removeMultiple(by: 4) else { return }
        let cardImageViewCreater = CardImageViewCreater(cards: cards, sideMargin: 5, topMargin: 20)
        let cardImageViews = cardImageViewCreater.createFewHorizontally(within: self.view.frame.width, divided: 7, align: .left)
        cardImageViews.forEach { self.view.addSubview($0) }
    }

    private func addCardImageViews() {
        guard let cards = cardDeck.removeMultiple(by: 7) else { return }
        let cardImageViewCreater = CardImageViewCreater(cards: cards, sideMargin: 5, topMargin: 100)
        let cardImageViews = cardImageViewCreater.createFullHorizontally(within: self.view.frame.width)
        cardImageViews.forEach { self.view.addSubview($0) }
        cardImages = cardImageViews
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        if motion == .motionShake {
            cardDeck.reset()
            cardImages.forEach { $0.removeFromSuperview() }
            addCardImageViews()
        }
    }

}

extension ViewController {

    private struct CardImageViewCreater {
        let cards: CardStack
        let sideMargin: CGFloat
        let topMargin: CGFloat

        private func calculateCardWidth(with frameWidth: CGFloat, divided: Int? = nil) -> CGFloat {
            let calculation = { number in (frameWidth - self.sideMargin * CGFloat(number + 2)) / CGFloat(number) }
            if let number = divided {
                return calculation(number)
            }
            return calculation(cards.count)
        }

        func createFullHorizontally(within frameWidth: CGFloat) -> [CardImageView] {
            var cardImageViews: [CardImageView] = []
            let width = calculateCardWidth(with: frameWidth)
            var positionX = sideMargin * 1.5
            for imageName in cards.imageNames {
                let origin = CGPoint(x: positionX, y: topMargin)
                let cardImageView = CardImageView(origin: origin, width: width)
                cardImageView.setImage(named: imageName)
                cardImageViews.append(cardImageView)
                positionX += width + sideMargin
            }
            return cardImageViews
        }

        enum Align: CGFloat {
            case left = 1
            case right = -1
        }

        func createFewHorizontally(within frameWidth: CGFloat, divided: Int, align: Align) -> [CardImageView] {
            var cardImageViews: [CardImageView] = []
            let width = calculateCardWidth(with: frameWidth, divided: divided)
            var positionX = sideMargin * 1.5
            if align == .right {
                positionX = frameWidth - width - positionX
            }
            let direction = align.rawValue
            for imageName in cards.imageNames {
                let origin = CGPoint(x: positionX, y: topMargin)
                let cardImageView = CardImageView(origin: origin, width: width)
                cardImageView.setImage(named: imageName)
                cardImageViews.append(cardImageView)
                positionX += (width + sideMargin) * direction
            }
            return cardImageViews
        }

    }

}
