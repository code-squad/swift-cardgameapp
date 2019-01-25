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
    private let cardViewLayout: CardViewLayout
    private var cardDeck: CardDeck

    required init?(coder aDecoder: NSCoder) {
        cardViewLayout = CardViewLayout(division: 7,
                                        sideMargin: 5,
                                        firstSideMarginRatio: 1.5,
                                        firstTopMargin: 20,
                                        topMarginInterval: 80)
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
        addCardDeckImageView()
        addCardImageViews()
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        if motion == .motionShake {
            cardDeck.reset()
            replaceImagesOfCardImageViews()
        }
    }

}

/* MARK: Create View related to Card */
extension ViewController {

    private func addCardSpaceViews() {
        let cardViewCreater = CardViewCreater(layout: cardViewLayout, frameWidth: view.frame.width)
        let cardSpaceViews = cardViewCreater.createSpaceViews(spaces: 4, line: 1)
        cardSpaceViews.forEach { view.addSubview($0) }
    }

    private func addCardDeckImageView() {
        guard let card = cardDeck.removeOne() else { return }
        card.flip()
        let aCard = CardStack(cards: [card])
        let cardViewCreater = CardViewCreater(layout: cardViewLayout, frameWidth: view.frame.width)
        let cardImageViews = cardViewCreater.createImageViews(of: aCard, line: 1, align: .right)
        cardImageViews.forEach { view.addSubview($0) }
    }

    private func addCardImageViews() {
        guard let cards = cardDeck.removeMultiple(by: 7) else { return }
        let cardViewCreater = CardViewCreater(layout: cardViewLayout, frameWidth: view.frame.width)
        let cardImageViews = cardViewCreater.createImageViews(of: cards, line: 2)
        cardImageViews.forEach { view.addSubview($0) }
        self.cardImageViews = cardImageViews
    }

    private func replaceImagesOfCardImageViews() {
        guard let cards = cardDeck.removeMultiple(by: 7) else { return }
        for (index, imageName) in cards.imageNames.enumerated() {
            guard index < cardImageViews.count else { return }
            cardImageViews[index].setImage(named: imageName)
        }
    }

    struct CardViewLayout {
        let division: Int
        let sideMargin: CGFloat
        let firstSideMarginRatio: CGFloat
        let firstTopMargin: CGFloat
        let topMarginInterval: CGFloat
    }

    private struct CardViewCreater {
        private let frameWidth: CGFloat
        private let division: Int
        private let sideMargin: CGFloat
        private let firstSideMarginRatio: CGFloat
        private let firstTopMargin: CGFloat
        private let topMarginInterval: CGFloat

        init(layout: CardViewLayout, frameWidth: CGFloat) {
            self.frameWidth = frameWidth
            division = layout.division
            sideMargin = layout.sideMargin
            firstSideMarginRatio = layout.firstSideMarginRatio
            firstTopMargin = layout.firstTopMargin
            topMarginInterval = layout.topMarginInterval
        }

        enum Align: CGFloat {
            case left = 1
            case right = -1
        }

        private var viewWidth: CGFloat {
            let widthExceptMargin = frameWidth - sideMargin * CGFloat(division + 2)
            return widthExceptMargin / CGFloat(division)
        }

        private func calculateTopMargin(of line: Int) -> CGFloat {
            return firstTopMargin + topMarginInterval * CGFloat(line - 1)
        }

        private func positionXOfFirstView(of width: CGFloat, aligned align: Align) -> CGFloat {
            var positionX = sideMargin * firstSideMarginRatio
            if align == .right {
                positionX = frameWidth - width - positionX
            }
            return positionX
        }

        func createImageViews(of cards: CardStack, line: Int, align: Align = .left) -> [CardImageView] {
            var cardImageViews: [CardImageView] = []
            let width = viewWidth
            let topMargin = calculateTopMargin(of: line)
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

        func createSpaceViews(spaces: Int, line: Int, align: Align = .left) -> [CardSpaceView] {
            var cardSpaceViews: [CardSpaceView] = []
            let width = viewWidth
            let topMargin = calculateTopMargin(of: line)
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
