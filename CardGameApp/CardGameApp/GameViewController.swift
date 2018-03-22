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
            gameView.setup()
            gameView.delegate = self
            view.addSubview(gameView)
        }
    }
    private var game: GameViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        gameView = GameView(frame: view.frame)
        game = GameViewModel()
        setDefaultTableauViews()
        bindDataInSpareView()
        bindDataInWasteView()
        bindDataInFoundationView()
//        bindDataInTableauView()
        for (view, viewModel) in zip(self.gameView.tableauViews, self.game.tableau) {
            self.bindDataInTableauView(viewModel, in: view)
        }
    }
}

extension GameViewController: CanHandleGesture, CanUpdateViewModel {

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            game.initialize()
            setDefaultTableauViews()
        }
    }

    func handleSingleTapOnSpare() {
        game.updateSpare()
    }

    func handleDoubleTapOnCard(tappedView: CardView, recognizer: UITapGestureRecognizer) {
        guard let tappedCard = tappedView.viewModel else { return }
        if let endLocation = game.canMoveToLocation(tappedCard.card) {
            let startLocation = tappedCard.location
            let startContainerOrigin = startLocation.origin(inside: gameView)
            let endContainerOrigin = endLocation.origin(inside: gameView)

            var startPoint = CGPoint()
            switch startLocation {
            case .tableau(let stackNumber):
                let heightExceptLast =
                    gameView.tableauViews[stackNumber].nextYPosition - gameView.config.cardSize.height*0.3
                let y = startContainerOrigin.y + heightExceptLast
                startPoint = CGPoint(x: startContainerOrigin.x, y: y)
            case .waste: startPoint = tappedView.convertOrigin(relativeTo: gameView)
            default: startPoint = startContainerOrigin
            }

            var endPoint = CGPoint()
            switch endLocation {
            case .tableau(let stackNumber):
                let height = gameView.tableauViews[stackNumber].nextYPosition
                let y = endContainerOrigin.y + height
                endPoint = CGPoint(x: endContainerOrigin.x, y: y)
            default: endPoint = endContainerOrigin
            }

            let movableCardView = MovableCardView(cardView: tappedView,
                                                  from: startLocation, to: endLocation,
                                                  startPoint: startPoint, endPoint: endPoint)
            movableCardView.delegate = self
            movableCardView.animateToMove()
        }

    }

    // 애니메이션 직후 동작 (뷰, 모델변경)
    func updateMovedCards(movableCardView: MovableCardView) {
        // 모델 변경
        game.moveFrontCard(from: movableCardView.fromLocation, to: movableCardView.toLocation) { [unowned self] in
            // 모델 변경 후, Tableau의 경우 스택뷰에 추가 (애니메이션 시에 추가가 안됐으므로)
//            if case let Location.tableau(stackNumber) = movableCardView.fromLocation {
//                self.gameView.tableauViews[stackNumber].removeCard(cardView: movableCardView.cardView)
//            }
//            if case let Location.tableau(stackNumber) = movableCardView.toLocation {
//                self.gameView.tableauViews[stackNumber].appendCard(cardView: movableCardView.cardView)
//            }
        }
    }

}

extension GameViewController {

    private func bindDataInSpareView() {
        game.spare.cardViewModels.bindAndFire { [unowned self] in
            if let viewModel = $0 {
                self.gameView.spareView.setViewModel(viewModel)
            } else {
                let refreshImage = UIImage(imageLiteralResourceName: GameViewModel.Settings.refresh)
                self.gameView.spareView.setImage(refreshImage)
            }
        }
    }

    private func bindDataInWasteView() {
        // 모델에 추가된 카드($0)가 있으면 뷰모델로 만든 후 뷰에 붙임.
        // 모델에서 카드가 제거되면 제거된 카드 그림 지우고 뷰에서 떼어냄.
        game.waste.cardViewModels.bind { [unowned self] in
            // 새 이미지가 있는 경우, 붙인다.
            if let viewModel = $0 {
                self.gameView.wasteView.appendCard(cardViewModel: viewModel)
            } else {
                self.gameView.wasteView.eraseAllImages()
                self.gameView.wasteView.removeAll()
            }
        }
    }

    private func bindDataInFoundationView() {
        // index: 0...3
        for (index, (view, viewModel)) in zip(gameView.foundationView.arrangedSubviews, game.foundation).enumerated() {
            switch viewModel.spaceState {
            case .exist(let card):
                card.bindAndFire {
                    let cardViewModel =
                        CardViewModel(card: $0, faceState: .up, borderState: .show, location: .foundation(index))
                    (view as? CardView)?.setViewModel(cardViewModel)
                }
            case .vacant: break
            }
        }
    }

    // 각 Tableau 스택의 데이터 바인딩.
    private func bindDataInTableauView(_ tableauViewModel: TableauViewModel, in stackView: TableauView) {
        tableauViewModel.cardViewModels.bind {
            // $0 = 현재 모델의 프론트(마지막) 카드.
            guard let isAdded = tableauViewModel.isAdded else { return }
            if isAdded {
                // 추가 - 앞면인 상태로 붙임
//                $0?.turnOver(toFace: .up)
                stackView.appendCard(cardViewModel: $0)
            } else {
                // 제거 - 제거 후 마지막 카드 뒤집음
                stackView.removeCards(count: 1)
                $0?.turnOver(toFace: .up)
            }
        }
    }

    // 맨 초기 tableau 카드 뷰에 데이터 삽입.
    func setDefaultTableauViews() {
        // index: 0...6
        for (stackView, tableauViewModel) in zip(gameView.tableauViews, game.tableau) {
            stackView.removeAllCards()
            tableauViewModel.turnOverLastCard(to: .up)
            tableauViewModel.cardViewModels.collection.forEach {
                stackView.appendCard(cardViewModel: $0)
            }
        }
    }

//    func bindWithTableauView() {
//        // index: 0...6
//        for (stackView, tableauViewModel) in zip(gameView.tableauViews, game.tableau) {
//            tableauViewModel.cardViewModels.bindAndFire { _ in
//                stackView.removeAllCards()
//                tableauViewModel.turnOverLastCard(to: .up)
//                tableauViewModel.cardViewModels.collection.forEach {
//                    stackView.appendCard(cardViewModel: $0)
//                }
//            }
//        }
//    }
}
