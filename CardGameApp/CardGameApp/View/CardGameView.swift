//
//  CardGameView.swift
//  CardGameApp
//
//  Created by 윤지영 on 04/02/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

class CardGameView: UIView {
    private var viewModel: CardGameViewModel!
    private let layout: CardGameViewLayout

    private var cardSpacesView: CardSpacesView!
    private var cardPileView: CardPileView!
    private var cardDeckView: CardDeckView!
    private var cardStacksView: CardStacksView!

    required init?(coder aDecoder: NSCoder) {
        self.layout = CardGameViewLayout(frame: UIScreen.main.bounds)
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        self.layout = CardGameViewLayout(frame: frame)
        super.init(frame: frame)
    }

    convenience init(frame: CGRect, viewModel: CardGameViewModel) {
        self.init(frame: frame)
        self.viewModel = viewModel
        setUp()
    }

    private func setUp() {
        createViews()
        addViews()
    }

    private func createViews() {
        let spaces = 4
        cardSpacesView = CardSpacesView(frame: layout.getFrameOfCardSpacesView(spaces: spaces), spaces: spaces)
        cardPileView = CardPileView(frame: layout.frameOfCardPileView, viewModel: viewModel.cardPileViewModel)
        cardDeckView = CardDeckView(frame: layout.frameOfCardDeckView, viewModel: viewModel.cardDeckViewModel)
        cardStacksView = CardStacksView(frame: layout.frameOfCardStacksView, viewModel: viewModel.cardStacksViewModel)
        addViews()
    }

    private func addViews() {
        addSubview(cardSpacesView)
        addSubview(cardPileView)
        addSubview(cardDeckView)
        addSubview(cardStacksView)
    }

}

/* MARK: User interaction events */
extension CardGameView {

    /* Touch */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        
        if touch.view == cardDeckView {
            viewModel.openCardFromCardDeck()
            moveCardViewFromCardDeckView()
        }
    }

    private func moveCardViewFromCardDeckView() {
        guard let cardView = cardDeckView.pop() else { return }
        cardPileView.push(cardView)
    }

    /* Shake Motion */
    func reset() {
        moveCardViewsToCardDeckView()
        viewModel.reset()
    }

    private func moveCardViewsToCardDeckView() {
        while !cardPileView.subviews.isEmpty {
            guard let cardView = cardPileView.pop() else { break }
            cardDeckView.push(cardView)
        }
    }

}
