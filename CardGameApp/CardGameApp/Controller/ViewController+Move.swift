//
//  ViewController+Move.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 18..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

// MARK: CardStackDummyViewDelegate

extension ViewController: CardStackDummyViewDelegate {
    func moveToCardStackDummyView(tappedView: [UIView], startIndex: Int, targetIndex: Int) {
        guard let cards = stackDummyVM.lastShowCards(index: startIndex, count: tappedView.count),
            let firstCard = cards.first else { return }
        let lastCardOfTargetStack = stackDummyVM.top(index: targetIndex)
        if firstCard.isDifferentColorAndPreviousRank(with: lastCardOfTargetStack) {
            let start = StartInfo(viewModel: self.stackDummyVM, index: startIndex, count: tappedView.count)
            let target = TargetInfo(viewModel: self.stackDummyVM, index: targetIndex)
            self.move(start: start, target: target, tappedView: tappedView, cards: cards)
        }
    }

    func pointOfCardDummyView(startIndex: Int) -> CGPoint? {
        guard let selectedCard = stackDummyVM.top(index: startIndex) else { return nil }
        if let targetIndex = cardDummyVM.targetIndex(card: selectedCard) {
            return movePoint(startIndex: startIndex, targetIndex: targetIndex)
        } else if let targetIndex = stackDummyVM.targetIndex(card: selectedCard) {
            return cardStackDummyView.movePoint(from: startIndex, to: targetIndex)
        }
        return nil
    }

    fileprivate func move(start: StartInfo, target: TargetInfo, tappedView: [UIView], cards: [Card]) {
        tappedView.forEach { $0.removeFromSuperview() }
        start.viewModel.pop(index: start.index, count: tappedView.count)
        target.viewModel.push(index: target.index, cards: cards)
    }

    fileprivate func move(start: StartInfo, target: TargetInfo, tappedView: UIView) {
        tappedView.removeFromSuperview()
        let selectedCard = start.viewModel.pop(index: start.index, count: start.count)
        target.viewModel.push(index: target.index, cards: selectedCard)
    }

    func moveCardViews(tappedView: UIView, startIndex: Int) {
        guard let selectedCard = stackDummyVM.top(index: startIndex) else { return }
        if let targetIndex = cardDummyVM.targetIndex(card: selectedCard) {
            let start = StartInfo(viewModel: self.stackDummyVM, index: startIndex, count: 1)
            let target = TargetInfo(viewModel: self.cardDummyVM, index: targetIndex)
            self.move(start: start, target: target, tappedView: tappedView)
        } else if let targetIndex = stackDummyVM.targetIndex(card: selectedCard) {
            let start = StartInfo(viewModel: self.stackDummyVM, index: startIndex, count: 1)
            let target = TargetInfo(viewModel: self.stackDummyVM, index: targetIndex)
            self.move(start: start, target: target, tappedView: tappedView)
        }
    }

    func movePoint(startIndex: Int, targetIndex: Int) -> CGPoint {
        let x = moveX(from: startIndex, to: targetIndex)
        let y = moveY(from: startIndex, to: targetIndex)
        return CGPoint(x: x, y: y)
    }

    func moveX(from startIndex: Int, to targetIndex: Int) -> CGFloat {
        let startX = getX(index: startIndex)
        let targetX = getX(index: targetIndex)
        return targetX - startX
    }

    func moveY(from startIndex: Int, to targetIndex: Int) -> CGFloat {
        let topconstant = stackDummyVM.count(cardStackIndex: startIndex) - 1
        let startY = cardStackDummyView.frame.origin.y + 30 * topconstant.cgfloat
        let targetY = Size.statusBarHeight
        return targetY - startY
    }

    func getX(index: Int) -> CGFloat {
        let idx = index.cgfloat
        return Size.constant * (idx + 1) + Size.cardWidth * idx
    }
}
