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
    private var cardDeck: CardDeck

    required init?(coder aDecoder: NSCoder) {
        cardDeck = CardDeck()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        addCardImageViews()
    }

    private func setBackground() {
        guard let image = UIImage(named: "bg_pattern.png") else { return }
        self.view.backgroundColor = UIColor(patternImage: image)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func addCardImageViews() {
        guard let cards = cardDeck.removeMultiple(by: 7) else { return }
        let cardImageViewCreater = CardImageViewCreater(cards: cards, sideMargin: 5, topMargin: 100)
        let cardImageViews = cardImageViewCreater.createHorizontally(within: self.view.frame.width)
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

        private func calculateCardWidth(with frameWidth: CGFloat) -> CGFloat {
            let numberOfCards = cards.count
            return (frameWidth - sideMargin * CGFloat(numberOfCards + 2)) / CGFloat(numberOfCards)
        }

        func createHorizontally(within frameWidth: CGFloat) -> [CardImageView] {
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

    }

}
