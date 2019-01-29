//
//  ViewController.swift
//  CardGameApp
//
//  Created by 윤지영 on 22/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var cardStackView: CardStacksView!
    private var cardDeckView: CardStackView!
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
                                    sizeRatio: 1.27,
                                    sideMargin: 5,
                                    firstSideMarginRatio: 1.5,
                                    firstTopMargin: 20,
                                    topMarginInterval: 80)
        cardViewFactory = CardViewFactory(layout: layout, frameWidth: view.frame.width)
    }

    private func setCardViews() {
        addCardSpaceViews()
        addCardDeckView()
        addCardStacksView()
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
        if let cardDeckView = cardViewFactory?.createDeckView(of: cardDeck, line: 1, align: .right) {
            self.cardDeckView = cardDeckView
            view.addSubview(self.cardDeckView)
        }
    }

    private func addCardStacksView() {
        let cardStacks = CardStacks(from: cardDeck)
        if let cardStackView = cardViewFactory?.createStackViews(of: cardStacks, line: 2) {
            self.cardStackView = cardStackView
            view.addSubview(self.cardStackView)
        }
    }

    private func replaceImagesOfCardViews() {
        let cardStacks = CardStacks(from: cardDeck)
        cardStackView.setImages(named: cardStacks.imageNames)
    }

}
