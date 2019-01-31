//
//  ViewController.swift
//  CardGameApp
//
//  Created by 윤지영 on 22/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var cardStacksView: CardStacksView!
    private var cardDeckView: CardDeckView!
    private var cardDeckOpenedView: CardDeckView!
    private var cardViewFactory: CardViewFactory?

    private let cardDeck: CardDeck

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
                                    sizeRatio: 1.27,
                                    overlap: 20,
                                    sideMargin: 5,
                                    firstSideMarginRatio: 1.5,
                                    firstTopMargin: 20,
                                    topMarginInterval: 80)
        cardViewFactory = CardViewFactory(layout: layout, frameWidth: view.frame.width)
    }

    private func setCardViews() {
        addCardSpaceViews()
        addCardStacksView()
        addCardDeckView()
        addCardDeckOpenedView()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        if touch.view == cardDeckView {
            guard let cardView = cardDeckView.popWithRefreshImage() else { return }
            cardView.flip()
            cardDeckOpenedView.push(cardView)
        }
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        if motion == .motionShake {
            cardDeck.reset()
            resetCardDeckView()
            replaceImagesOfCardViews()
        }
    }

}

/* MARK: Create View related to Card */
extension ViewController {

    private func addCardSpaceViews() {
        if let cardSpaceViews = cardViewFactory?.createSpaceViews(spaces: 4) {
            cardSpaceViews.forEach { view.addSubview($0) }
        }
    }

    private func addCardDeckView() {
        if let cardDeckView = cardViewFactory?.createDeckView(of: cardDeck, align: .right) {
            self.cardDeckView = cardDeckView
            view.addSubview(self.cardDeckView)
        }
    }

    private func addCardDeckOpenedView() {
        if let cardDeckOpenedView = cardViewFactory?.createDeckView(of: nil, at: 2, align: .right) {
            self.cardDeckOpenedView = cardDeckOpenedView
            view.addSubview(self.cardDeckOpenedView)
        }
    }

    private func addCardStacksView() {
        let cardStacks = CardStacks(from: cardDeck)
        if let cardStacksView = cardViewFactory?.createStacksView(of: cardStacks) {
            self.cardStacksView = cardStacksView
            view.addSubview(self.cardStacksView)
        }
    }

    private func resetCardDeckView() {
        while(!cardDeckOpenedView.isEmpty) {
            guard let cardView = cardDeckOpenedView.pop() else { return }
            guard let newCard = cardDeck.removeOne() else { return }
            cardView.flip()
            cardView.viewModel = CardViewModel(card: newCard)
            cardDeckView.push(cardView)
        }
    }

    private func replaceImagesOfCardViews() {
        let newCardStacks = CardStacks(from: cardDeck)
        cardStacksView.viewModel = CardStacksViewModel(cardStacks: newCardStacks)
        cardStacksView.refresh()
    }

}
