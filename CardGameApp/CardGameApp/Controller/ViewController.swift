//
//  ViewController.swift
//  CardGameApp
//
//  Created by 윤지영 on 22/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var cardViews: [CardView]!
    private var cardViewFactory: CardViewFactory?
    private var cardDeck: CardDeck

    required init?(coder aDecoder: NSCoder) {
        cardDeck = CardDeck()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        setCardViewFactory()
        setCardViews()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func setBackground() {
        guard let image = UIImage(named: "bg_pattern.png") else { return }
        self.view.backgroundColor = UIColor(patternImage: image)
    }

    private func setCardViewFactory() {
        let layout = CardViewLayout(division: 7,
                                    sideMargin: 5,
                                    firstSideMarginRatio: 1.5,
                                    firstTopMargin: 20,
                                    topMarginInterval: 80)
        cardViewFactory = CardViewFactory(layout: layout, frameWidth: view.frame.width)
    }

    private func setCardViews() {
        addCardSpaceViews()
        addCardDeckView()
        addCardViews()
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        if motion == .motionShake {
            cardDeck.reset()
            replaceImagesOfCardViews()
        }
    }

}

/* MARK: Create View related to Card */
extension ViewController {

    private func addCardSpaceViews() {
        if let cardSpaceViews = cardViewFactory?.createSpaceViews(spaces: 4, line: 1) {
            cardSpaceViews.forEach { view.addSubview($0) }
        }
    }

    private func addCardDeckView() {
        guard let card = cardDeck.removeOne() else { return }
        card.flip()
        let aCard = CardStack(cards: [card])
        if let cardViews = cardViewFactory?.createViews(of: aCard, line: 1, align: .right) {
            cardViews.forEach { view.addSubview($0) }
        }
    }

    private func addCardViews() {
        let cardStacks = CardStacks(from: cardDeck).cardStacks
        if let cardStackViews = cardViewFactory?.createStackViews(of: cardStacks, line: 2) {
            cardStackViews.forEach {
                $0.addAllSubviews { [unowned self] view in self.view.addSubview(view) }
            }
        }
    }

    private func replaceImagesOfCardViews() {
        guard let cards = cardDeck.removeMultiple(by: 7) else { return }
        for (index, imageName) in cards.imageNames.enumerated() {
            guard index < cardViews.count else { return }
            cardViews[index].setImage(named: imageName)
        }
    }

}
