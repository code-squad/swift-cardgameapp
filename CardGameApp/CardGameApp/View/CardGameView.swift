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

    private var cardStacksView: CardStacksView!
    private var cardDeckView: CardDeckView!
    private var cardPileView: CardPileView!
    private var cardSpacesView: [CardSpaceView]!

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
        cardStacksView = CardStacksView(frame: layout.frameOfCardStacksView, viewModel: viewModel.cardStacksViewModel)
        cardDeckView = CardDeckView(frame: layout.frameOfCardDeckView, viewModel: viewModel.cardDeckViewModel)
        cardPileView = CardPileView(frame: layout.frameOfCardPileView, viewModel: viewModel.cardPileViewModel)
        cardSpacesView = layout.createSpaceViews(spaces: 4)
        addViews()
    }

    private func addViews() {
        addSubview(cardStacksView)
        addSubview(cardDeckView)
        addSubview(cardPileView)
        cardSpacesView.forEach { addSubview($0) }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        
        if touch.view == cardDeckView {
            viewModel.openCardFromCardDeck()
            moveCardFromCardDeck()
        }
    }

    private func moveCardFromCardDeck() {
        guard let cardView = cardDeckView.pop() else { return }
        cardPileView.push(cardView)
    }

}
