//
//  GameViewController.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 12..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    private(set) var gameView: GameView! {
        didSet {
            gameView.delegate = self
            gameView.refreshDelegate = self
            view.addSubview(gameView)
        }
    }
    private var gameViewModel: GameViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        gameViewModel = GameViewModel()
        gameView = GameView(frame: view.frame, game: gameViewModel)
        gameViewModel.initialize()
        gameView.initialize()
    }
}

extension GameViewController: CardViewActionDelegate, RefreshActionDelegate {
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            gameViewModel.initialize()
            gameView.newGame(with: gameViewModel)
        }
    }

    func onCardViewDoubleTapped(tappedView: CardView) {
        moveToSuitableLocation(tappedView, toLocation: nil, shouldTurnOverFace: false)
    }

    func onSpareViewTapped(tappedView: CardView) {
        moveToSuitableLocation(tappedView, toLocation: nil, shouldTurnOverFace: true)
    }

    func onRefreshButtonTapped() {
        for card in gameView.wasteView.reversed() {
            moveToSuitableLocation(card, toLocation: .spare, shouldTurnOverFace: true)
        }
    }

    // MARK: - PRIVATE

    private func moveToSuitableLocation(_ cardView: CardView, toLocation: Location?, shouldTurnOverFace: Bool) {
        guard let cardViewModel = cardView.viewModel else { return }
        shouldTurnOverFace ? cardViewModel.turnOver() : nil

        let cardViewsBelow = getCardViewsBelowIfNeeded(below: cardView, on: cardViewModel.location.value)

        // 탭한 뷰의 적정 위치 찾은 후
        if let suitableLocation =
            (toLocation == nil) ? gameViewModel.suitableLocation(for: cardViewModel) : toLocation {
            // 뷰 업데이트
            let movableCardView = MovableCardView(cardView: cardView,
                                                  cardViewsBelow: cardViewsBelow,
                                                  endLocation: suitableLocation)
            movableCardView.delegate = self
            gameView.move(movableCardView)
        }
    }

    private func getCardViewsBelowIfNeeded(below tappedCardView: CardView, on fromLocation: Location) -> [CardView]? {
        var cardViewsBelow: [CardView]?
        if case let Location.tableau(index) = fromLocation {
            let tableauView = gameView.tableauViewContainer.at(index)
            cardViewsBelow = tableauView.below(cardView: tappedCardView)
        }
        return cardViewsBelow
    }

}

extension GameViewController: UpdateModelDelegate {
    func refreshWaste() {
        gameViewModel.refreshWaste()
    }

    func move(cardViewModel: CardViewModel, from startLocation: Location, to endLocation: Location) {
        let fromLocation = cardViewModel.location.value
        gameViewModel.move(cardViewModel: cardViewModel, from: fromLocation, to: endLocation)
    }

    func update(cardViewModel: CardViewModel, to endLocation: Location) {
        cardViewModel.location.value = endLocation
    }

}
