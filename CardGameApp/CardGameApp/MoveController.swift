//
//  DragAction.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 3. 13..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class MoveController {
    private var viewOrigin: CGPoint?

    private let cardView: CardView
    private let cardStackView: CardStackView
    private let parentView: UIStackView
    private let mainView: UIView

    private var originParentModel: Sendable?
    private var isToFoundations: Bool = true
    private var targetParentModel: Receivable? {
        didSet {
            if targetParentModel is SevenPilesViewModel {
                isToFoundations = false
            }
        }
    }

    init?(cardView: CardView) {
        self.cardView = cardView
        guard let cardStackView = cardView.superview as? CardStackView else { return nil }
        guard cardView == cardStackView.subviews[cardStackView.subviews.count-1] else { return nil }
        guard let parentView = cardStackView.superview as? UIStackView else { return nil }
        guard let mainView = parentView.superview else { return nil }

        self.cardStackView = cardStackView
        self.parentView = parentView
        self.mainView = mainView

        self.originParentModel = getOriginParentModel()
    }

    private func getOriginParentModel() -> Sendable? {
        if (parentView as? OpenedCardDeckView) != nil {
            return OpenedCardDeckViewModel.sharedInstance()
        } else if (parentView as? SevenPilesView) != nil {
            return SevenPilesViewModel.sharedInstance()
        } else {
            return nil
        }
    }

    private func getTargetParentModel(card: Card) -> Receivable? {
        return Target.getParent(of: card)
    }

    func doubleTap() {
        guard let cardInformation = originParentModel?.getSelectedCardInformation(image: cardView.storedImage)
            else { return }
        self.targetParentModel = getTargetParentModel(card: cardInformation.card)
        guard let target =
            targetParentModel?.availablePosition(of: cardInformation.card) else { return }
        mainView.isUserInteractionEnabled = false
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 1.0,
            delay: 0.0,
            options: [.curveLinear],
            animations: {
                self.mainView.bringSubview(toFront: self.parentView)
                self.parentView.bringSubview(toFront: self.cardStackView)
                self.moveCardView(to: target)
            },
            completion: { _ in
                self.parentView.insertSubview(self.cardStackView, at: cardInformation.indexes.xIndex)
                self.moveCardModel(cardIndexes: cardInformation.indexes)
                self.mainView.isUserInteractionEnabled = true
            }
        )
    }

    private func moveCardView(to target: CardIndexes) {
        let cardWidth = UIScreen.main.bounds.width / CGFloat(Figure.Size.countInRow.value)
        let globalPoint = cardStackView.convert(cardView.frame.origin, to: nil)
        let dx = (cardWidth * CGFloat(target.xIndex)) + CGFloat(Figure.Size.xGap.value)
        cardView.frame.origin.x -= globalPoint.x - dx
        var dy = CGFloat(Figure.YPosition.topMargin.value)
        if !isToFoundations {
            dy = CGFloat(Figure.YPosition.cardPileTopMargin.value +
                (Figure.YPosition.betweenCards.value * target.yIndex))
        }
        cardView.frame.origin.y -= globalPoint.y - dy
    }

    private func moveCardModel(cardIndexes: CardIndexes) {
        _ = targetParentModel?.push(card: (originParentModel?.pop(index: cardIndexes.xIndex))!)
    }

    func setViewOrigin(at viewOrigin: CGPoint) {
        self.viewOrigin = viewOrigin
    }

    func moveBegan() {
        mainView.bringSubview(toFront: parentView)
        parentView.bringSubview(toFront: cardStackView)
    }

    func moveChanged(with recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: cardView)
        cardView.center = CGPoint(x: cardView.center.x + translation.x, y: cardView.center.y + translation.y)
        recognizer.setTranslation(CGPoint.zero, in: mainView)
    }

    func moveBackToOrigin() {
        let globalPoint = cardStackView.convert(cardView.frame.origin, to: nil)
        guard let cardInformation = originParentModel?.getSelectedCardInformation(image: cardView.storedImage)
            else { return }
        UIView.animate(withDuration: 0.5, animations: {
            self.cardView.frame.origin.x -= globalPoint.x - (self.viewOrigin?.x ?? 0.0)
            self.cardView.frame.origin.y -= globalPoint.y - (self.viewOrigin?.y ?? 0.0)
        })
        parentView.insertSubview(cardStackView, at: cardInformation.indexes.xIndex)
    }

}
