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
        let cardViewCreater = CardViewFactory(layout: cardViewLayout, frameWidth: view.frame.width)
        let cardSpaceViews = cardViewCreater.createSpaceViews(spaces: 4, line: 1)
        cardSpaceViews.forEach { view.addSubview($0) }
    }

    private func addCardDeckImageView() {
        guard let card = cardDeck.removeOne() else { return }
        card.flip()
        let aCard = CardStack(cards: [card])
        let cardViewCreater = CardViewFactory(layout: cardViewLayout, frameWidth: view.frame.width)
        let cardImageViews = cardViewCreater.createImageViews(of: aCard, line: 1, align: .right)
        cardImageViews.forEach { view.addSubview($0) }
    }

    private func addCardImageViews() {
        guard let cards = cardDeck.removeMultiple(by: 7) else { return }
        let cardViewCreater = CardViewFactory(layout: cardViewLayout, frameWidth: view.frame.width)
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

}
