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
    fileprivate func move(start: StartInfo, target: TargetInfo, tappedView: UIView) {
        tappedView.removeFromSuperview()
        let selectedCard = start.viewModel.pop(index: start.index)!
        target.viewModel.push(index: target.index, card: selectedCard)
    }

    func moveToCardStackDummyView(_ cardStackDummyView: CardStackDummyView, tappedView: UIView, startIndex: Int) {
        guard let selectedCard = stackDummyVM.top(index: startIndex),
            cardDummyVM.targetIndex(card: selectedCard) == nil,
            let targetIndex = stackDummyVM.targetIndex(card: selectedCard) else {
                return
        }
        let moveOrigin = cardStackDummyView.movePoint(from: startIndex, to: targetIndex)
        UIView.animate(
            withDuration: 0.5,
            animations: {
                tappedView.frame.origin.x += moveOrigin.x
                tappedView.frame.origin.y += moveOrigin.y
        },
            completion: { _ in
                let start = StartInfo(viewModel: self.stackDummyVM, index: startIndex)
                let target = TargetInfo(viewModel: self.stackDummyVM, index: targetIndex)
                self.move(start: start, target: target, tappedView: tappedView)}
        )
    }

    func moveToCardDummyView(_ cardStackDummyView: CardStackDummyView, tappedView: UIView, startIndex: Int) {
        let constant: CGFloat = 7.5
        guard let selectedCard = stackDummyVM.top(index: startIndex),
            let targetIndex = cardDummyVM.targetIndex(card: selectedCard) else {
                return
        }
        let topViewPos = cardDummyView.position(index: targetIndex)
        let moveXPos = cardStackDummyView.moveX(from: 0, to: startIndex)
        UIView.animate(
            withDuration: 0.5,
            animations: {
                tappedView.frame.origin.x = -moveXPos
                tappedView.frame.origin.x += topViewPos.x
                tappedView.frame.origin.y = -(constant + Size.cardHeight) },
            completion: { _ in
                let start = StartInfo(viewModel: self.stackDummyVM, index: startIndex)
                let target = TargetInfo(viewModel: self.cardDummyVM, index: targetIndex)
                self.move(start: start, target: target, tappedView: tappedView)
        })
    }
}
