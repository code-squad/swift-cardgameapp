//
//  ViewController.swift
//  CardGameApp
//
//  Created by 윤지영 on 22/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var cardImageViews: [CardImageView]!
    private var cardDeck: CardDeck

    private let division: Int = 7
    private let sideMargin: CGFloat = 5
    private let firstTopMargin: CGFloat = 20
    private let topMarginInterval: CGFloat = 80

    required init?(coder aDecoder: NSCoder) {
        cardDeck = CardDeck()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        setCardViews()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func setBackground() {
        guard let image = UIImage(named: "bg_pattern.png") else { return }
        self.view.backgroundColor = UIColor(patternImage: image)
    }

    private func setCardViews() {
        addCardSpaceViews()
        setCardDeckImageView()
        addCardImageViews()
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        if motion == .motionShake {
            cardDeck.reset()
            cardImageViews.forEach { $0.removeFromSuperview() }
            addCardImageViews()
        }
    }

}

/* MARK: Create View related to Card */
extension ViewController {

    private func addCardSpaceViews() {
        let cardViewCreater = CardViewCreater(frameWidth: view.frame.width,
                                              sideMargin: sideMargin,
                                              topMargin: firstTopMargin)
        let cardSpaceViews = cardViewCreater.createSpaceView(spaces: 4, division: division)
        cardSpaceViews.forEach { view.addSubview($0) }
    }

    private func setCardDeckImageView() {
        guard let card = cardDeck.removeOne() else { return }
        card.flip()
        let cardViewCreater = CardViewCreater(frameWidth: view.frame.width,
                                              sideMargin: sideMargin,
                                              topMargin: firstTopMargin)
        let cardImageViews = cardViewCreater.createImageViews(of: CardStack(cards: [card]),
                                                              division: division, align: .right)
        cardImageViews.forEach { view.addSubview($0) }
    }

    private func addCardImageViews() {
        guard let cards = cardDeck.removeMultiple(by: 7) else { return }
        let cardViewCreater = CardViewCreater(frameWidth: view.frame.width,
                                              sideMargin: sideMargin,
                                              topMargin: firstTopMargin + topMarginInterval)
        let cardImageViews = cardViewCreater.createImageViews(of: cards, division: division)
        cardImageViews.forEach { view.addSubview($0) }
        self.cardImageViews = cardImageViews
    }

    private struct CardViewCreater {
        let frameWidth: CGFloat
        let sideMargin: CGFloat
        let topMargin: CGFloat

        private let firstSideMarginRatio: CGFloat = 1.5

        enum Align: CGFloat {
            case left = 1
            case right = -1
        }

        private func calculateViewWidth(of division: Int) -> CGFloat {
            return (frameWidth - sideMargin * CGFloat(division + 2)) / CGFloat(division)
        }

        private func positionXOfFirstView(of width: CGFloat, aligned align: Align) -> CGFloat {
            var positionX = sideMargin * firstSideMarginRatio
            if align == .right {
                positionX = frameWidth - width - positionX
            }
            return positionX
        }

        func createImageViews(of cards: CardStack, division: Int, align: Align = .left) -> [CardImageView] {
            var cardImageViews: [CardImageView] = []
            let width = calculateViewWidth(of: division)
            var positionX = positionXOfFirstView(of: width, aligned: align)
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

        func createSpaceView(spaces: Int, division: Int, align: Align = .left) -> [CardSpaceView] {
            var cardSpaceViews: [CardSpaceView] = []
            let width = calculateViewWidth(of: division)
            var positionX = positionXOfFirstView(of: width, aligned: align)
            let direction = align.rawValue
            for _ in 0..<spaces {
                let origin = CGPoint(x: positionX, y: topMargin)
                let cardSpaceView = CardSpaceView(origin: origin, width: width)
                cardSpaceViews.append(cardSpaceView)
                positionX += (width + sideMargin) * direction
            }
            return cardSpaceViews
        }

    }

}
