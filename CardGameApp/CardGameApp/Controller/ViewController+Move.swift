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
        case is WasteView:
            return wasteVM
        case is TableauPilesView:
            return tableauPilesVM
        default: return nil
        }
    }

    func originOfTargetView(view: MovableView, startIndex: Int) -> CGPoint? {
        guard let vm = startVM(view: view) else { return nil }
        guard let selectedCard = vm.top(index: startIndex) else { return nil }
        let startPos = view.coordinate(index: startIndex)
        var targetPos: CGPoint?
        if let targetIndex = foundationPilesVM.targetIndex(card: selectedCard) {
            targetPos = foundationPilesView.targetCoordinate(index: targetIndex)
        } else if let targetIndex = tableauPilesVM.targetIndex(card: selectedCard) {
            targetPos = tableauPilesView.targetCoordinate(index: targetIndex)
        }
        guard let target = targetPos else { return nil }
        let x = target.x - startPos.x
        let y = target.y - startPos.y
        return CGPoint(x: x, y: y)
    }

    func moveCardViews(view: MovableView, tappedView: UIView, startIndex: Int) {
        guard let vm = startVM(view: view) else { return }
        guard let selectedCard = vm.top(index: startIndex) else { return }
        if let targetIndex = foundationPilesVM.targetIndex(card: selectedCard) {
            let start = StartInfo(viewModel: vm, index: startIndex, count: 1)
            let target = TargetInfo(viewModel: foundationPilesVM, index: targetIndex)
            self.move(start: start, target: target, tappedView: tappedView)
        } else if let targetIndex = tableauPilesVM.targetIndex(card: selectedCard) {
            let start = StartInfo(viewModel: vm, index: startIndex, count: 1)
            let target = TargetInfo(viewModel: tableauPilesVM, index: targetIndex)
            self.move(start: start, target: target, tappedView: tappedView)
        }
    }

    func dragCardViews(startView: MovableView, tappedView: [UIView], startIndex: Int, targetPoint: CGPoint) {
        guard let startVM = startVM(view: startView) else { return }
        guard let cards = startVM.faceUpCards(index: startIndex, count: tappedView.count),
            let firstCard = cards.first else { return }
        if let targetPos = foundationPilesView.position(targetPoint),
            firstCard.isSameSuitAndNextRank(with: foundationPilesVM.top(index: targetPos.stackIndex)) {
            let start = StartInfo(viewModel: startVM, index: startIndex, count: tappedView.count)
            let target = TargetInfo(viewModel: foundationPilesVM, index: targetPos.stackIndex)
            self.move(start: start, target: target, tappedView: tappedView, cards: cards)
        } else if let targetPos = tableauPilesView.position(targetPoint),
            firstCard.isDifferentColorAndPreviousRank(with: tableauPilesVM.top(index: targetPos.stackIndex)) {
            let start = StartInfo(viewModel: startVM, index: startIndex, count: tappedView.count)
            let target = TargetInfo(viewModel: tableauPilesVM, index: targetPos.stackIndex)
            self.move(start: start, target: target, tappedView: tappedView, cards: cards)
        }
    }
}
