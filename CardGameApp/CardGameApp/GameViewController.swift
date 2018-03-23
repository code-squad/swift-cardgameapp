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

extension GameViewController: CardViewActionDelegate {
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            gameViewModel.initialize()
            gameView.newGame(with: gameViewModel)
        }
    }

    func onSpareViewTapped(tappedView: CardView) {
        guard let tappedCardViewModel = tappedView.viewModel else { return }
        tappedCardViewModel.turnOver(to: .up)
        // 탭한 뷰의 적정 위치 찾은 후
        if let tolocation = gameViewModel.suitableLocation(for: tappedCardViewModel) {
            // 뷰 업데이트
            let movableCardView = AnimatableCard(cardView: tappedView, endLocation: tolocation)
            gameView.move(movableCardView)
            // 뷰 업데이트 후 뷰모델 및 모델 업데이트
            tappedView.viewModel?.location.value = tolocation
            gameViewModel.moveToWaste(tappedCardViewModel)
        }
    }

    func onRefreshButtonTapped() {
        for card in gameView.laidCards {
            guard let cardViewModel = card.viewModel else { break }
            if case Location.waste = cardViewModel.location.value {
                card.viewModel?.turnOver(to: .down)
                let movableCard = AnimatableCard(cardView: card, endLocation: .spare)
                gameView.move(movableCard)
                // 뷰 업데이트 후 뷰모델 및 모델 업데이트
                card.viewModel?.location.value = .spare
                gameViewModel.refreshWaste()
            }
        }
    }

    func onCardViewDoubleTapped(tappedView: CardView) {
        guard let tappedCardViewModel = tappedView.viewModel else { return }
        let fromLocation = tappedCardViewModel.location.value
        // 탭한 뷰의 적정 위치 찾은 후
        if let location = gameViewModel.suitableLocation(for: tappedCardViewModel) {
            // 뷰 업데이트
            let movableCardView = AnimatableCard(cardView: tappedView, endLocation: location)
            gameView.move(movableCardView)
            // 뷰 업데이트 후 뷰모델 및 모델 업데이트
            tappedView.viewModel?.location.value = location
            gameViewModel.move(cardViewModel: tappedCardViewModel, from: fromLocation, to: location)
        }
    }

}
