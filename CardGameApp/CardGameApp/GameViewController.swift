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
        moveToSuitableLocation(tappedView, shouldTurnOverFace: false)
    }

    func onSpareViewTapped(tappedView: CardView) {
        moveToSuitableLocation(tappedView, shouldTurnOverFace: true)
    }

    func onRefreshButtonTapped() {
        for card in gameView.wasteView {
            card.viewModel?.turnOver(to: .down)
            let movableCard = AnimatableCard(cardView: card, endLocation: .spare)
            gameView.move(movableCard)
            // 뷰 업데이트 후 뷰모델 및 모델 업데이트
            card.viewModel?.location.value = .spare
            gameViewModel.refreshWaste()
        }
    }

    // MARK: - PRIVATE

    private func moveToSuitableLocation(_ cardView: CardView, shouldTurnOverFace: Bool) {
        guard let cardViewModel = cardView.viewModel else { return }
        shouldTurnOverFace ? cardViewModel.turnOver() : nil
        // 탭한 뷰의 적정 위치 찾은 후
        if let endLocation = gameViewModel.suitableLocation(for: cardViewModel) {
            let fromLocation = cardViewModel.location.value
            // 뷰 업데이트
            let movableCardView = AnimatableCard(cardView: cardView, endLocation: endLocation)
            gameView.move(movableCardView)
            // 뷰 업데이트 후 뷰모델 및 모델 업데이트
            cardView.viewModel?.location.value = endLocation
            gameViewModel.move(cardViewModel: cardViewModel, from: fromLocation, to: endLocation)
        }
    }

}
