//
//  ViewController+Move.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 18..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

extension ViewController {

    fileprivate func move(start: StartInfo, target: TargetInfo, tappedView: UIView) {
        tappedView.removeFromSuperview()
        let selectedCard = start.viewModel.pop(index: start.index, count: start.count)
        target.viewModel.push(index: target.index, cards: selectedCard)
    }

    fileprivate func move(start: StartInfo, target: TargetInfo, tappedView: [UIView], cards: [Card]) {
        tappedView.forEach { $0.removeFromSuperview() }
        start.viewModel.pop(index: start.index, count: tappedView.count)
        target.viewModel.push(index: target.index, cards: cards)
    }

    func startVM(view: MovableView) -> MovableViewModel? {
        switch view {
        case is ShowCardView:
            return showCardVM
        case is CardStackDummyView:
            return stackDummyVM
        default: return nil
        }
    }

    func originOfTargetView(view: MovableView, startIndex: Int) -> CGPoint? {
        guard let vm = startVM(view: view) else { return nil }
        guard let selectedCard = vm.top(index: startIndex) else { return nil }
        let startPos = view.coordinate(index: startIndex)
        var targetPos: CGPoint?
        if let targetIndex = cardDummyVM.targetIndex(card: selectedCard) {
            targetPos = cardDummyView.targetCoordinate(index: targetIndex)
        } else if let targetIndex = stackDummyVM.targetIndex(card: selectedCard) {
            targetPos = cardStackDummyView.targetCoordinate(index: targetIndex)
        }
        guard let target = targetPos else { return nil }
        let x = target.x - startPos.x
        let y = target.y - startPos.y
        return CGPoint(x: x, y: y)
    }

    func moveCardViews(view: MovableView, tappedView: UIView, startIndex: Int) {
        guard let vm = startVM(view: view) else { return }
        guard let selectedCard = vm.top(index: startIndex) else { return }
        if let targetIndex = cardDummyVM.targetIndex(card: selectedCard) {
            let start = StartInfo(viewModel: vm, index: startIndex, count: 1)
            let target = TargetInfo(viewModel: self.cardDummyVM, index: targetIndex)
            self.move(start: start, target: target, tappedView: tappedView)
        } else if let targetIndex = stackDummyVM.targetIndex(card: selectedCard) {
            let start = StartInfo(viewModel: vm, index: startIndex, count: 1)
            let target = TargetInfo(viewModel: self.stackDummyVM, index: targetIndex)
            self.move(start: start, target: target, tappedView: tappedView)
        }
    }

    func dragCardViews(startView: MovableView, tappedView: [UIView], startIndex: Int, targetPoint: CGPoint) {
        guard let startVM = startVM(view: startView) else { return }
        guard let cards = startVM.lastShowCards(index: startIndex, count: tappedView.count),
            let firstCard = cards.first else { return }
        if let targetPos = cardDummyView.position(targetPoint),
            firstCard.isSameSuitAndNextRank(with: cardDummyVM.top(index: targetPos.stackIndex)) {
            let start = StartInfo(viewModel: startVM, index: startIndex, count: tappedView.count)
            let target = TargetInfo(viewModel: cardDummyVM, index: targetPos.stackIndex)
            self.move(start: start, target: target, tappedView: tappedView, cards: cards)
        } else if let targetPos = cardStackDummyView.position(targetPoint),
            firstCard.isDifferentColorAndPreviousRank(with: stackDummyVM.top(index: targetPos.stackIndex)) {
            let start = StartInfo(viewModel: startVM, index: startIndex, count: tappedView.count)
            let target = TargetInfo(viewModel: stackDummyVM, index: targetPos.stackIndex)
            self.move(start: start, target: target, tappedView: tappedView, cards: cards)
        }
    }


}
