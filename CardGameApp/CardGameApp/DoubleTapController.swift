//
//  DoubleTapController.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 3. 19..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class DoubleTapController {
    private let original: OriginalInformation
    private var isToFoundations: Bool = true
    private var targetParentModel: Receivable? {
        didSet {
            if targetParentModel is SevenPilesViewModel {
                isToFoundations = false
            } else {
                isToFoundations = true
            }
        }
    }

    init?(original: OriginalInformation) {
        self.original = original
    }

    private func moveCardModel(from cardIndexes: CardIndexes, to target: CardIndexes) {
        _ = targetParentModel?.push(cards: (original.originParentModel!.pop(indexes: cardIndexes)),
                                    indexes: target)
    }

    private func checkFinished() {
        if let targetModel = targetParentModel as? FoundationsViewModel, targetModel.isSuccess() {
            NotificationCenter.default.post(name: .success, object: self, userInfo: nil)
        }
    }

    func doubleTap() {
        // check it is the last card of a card stack
        guard original.isDoubleTapable() else { return }
        guard original.cardInformation != nil else { return }
        let targetInformation = TargetInformation(of: original.cardInformation!.card)
        self.targetParentModel = targetInformation.parentModel
        guard let target = targetParentModel?.availablePosition(of: original.cardInformation!.card) else { return }
        original.mainView.isUserInteractionEnabled = false
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 1.0,
            delay: 0.0,
            options: [.curveLinear],
            animations: {
                self.original.animationBegan()
                self.moveCardView(to: target)
            },
            completion: { _ in
                self.original.animationCompletion()
                self.moveCardModel(from: (self.original.cardInformation!.indexes), to: target)
                self.checkFinished()
                self.original.mainView.isUserInteractionEnabled = true
            }
        )
    }

    private func moveCardView(to target: CardIndexes) {
        let cardWidth = UIScreen.main.bounds.width / CGFloat(Figure.Size.countInRow.value)
        let globalPoint = original.cardStackView.convert(original.cardView.frame.origin, to: nil)
        let dx = (cardWidth * CGFloat(target.xIndex)) + CGFloat(Figure.Size.xGap.value)
        original.cardView.frame.origin.x -= globalPoint.x - dx
        var dy = CGFloat(Figure.YPosition.topMargin.value)
        if !isToFoundations {
            dy = CGFloat(Figure.YPosition.cardPileTopMargin.value +
                (Figure.YPosition.betweenCards.value * target.yIndex))
        }
        original.cardView.frame.origin.y -= globalPoint.y - dy
    }

}
