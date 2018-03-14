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

    private var cardInformation: CardInformation?
    private var cardPackForDragging: [CardView]

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
        guard let parentView = cardStackView.superview as? UIStackView else { return nil }
        guard let mainView = parentView.superview else { return nil }

        self.cardStackView = cardStackView
        self.parentView = parentView
        self.mainView = mainView
        self.cardPackForDragging = []
        self.originParentModel = getOriginParentModel()
        self.cardInformation = getCardInformation()
        setCardPackForDragging()
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

    private func getCardInformation() -> CardInformation? {
        return originParentModel?.getSelectedCardInformation(image: cardView.storedImage)
    }

    private func setCardPackForDragging() {
        for index in (cardInformation?.indexes.yIndex)!..<cardStackView.subviews.count {
            guard let card = cardStackView.subviews[index] as? CardView else { continue }
            self.cardPackForDragging.append(card)
        }
    }

    private func getTargetParentModel(card: Card) -> Receivable? {
        return Target.getParent(of: card)
    }

    func doubleTap() {
        // check it is the last card of a card stack
        guard cardView == cardStackView.subviews[cardStackView.subviews.count-1] else { return }
        guard cardInformation != nil else { return }
        self.targetParentModel = getTargetParentModel(card: cardInformation!.card)
        guard let target = targetParentModel?.availablePosition(of: cardInformation!.card) else { return }
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
                self.parentView.insertSubview(self.cardStackView, at: self.cardInformation!.indexes.xIndex)
                self.moveCardModel(cardIndexes: self.cardInformation!.indexes)
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
        for targetView in cardPackForDragging {
            moveChanged(targetView: targetView, with: translation)
        }
        recognizer.setTranslation(CGPoint.zero, in: mainView)
    }

    private func moveChanged(targetView: CardView, with translation: CGPoint) {
        targetView.center = CGPoint(x: targetView.center.x + translation.x, y: targetView.center.y + translation.y)
    }

    func moveBackToOrigin() {
        let globalPoint = cardStackView.convert(cardView.frame.origin, to: nil)
        self.mainView.isUserInteractionEnabled = false
        for index in cardPackForDragging.indices {
            UIViewPropertyAnimator.runningPropertyAnimator(
                withDuration: 0.5,
                delay: 0.0,
                options: [.curveLinear],
                animations: {
                    self.cardPackForDragging[index].frame.origin.x -= globalPoint.x - (self.viewOrigin!.x)
                    self.cardPackForDragging[index].frame.origin.y -= globalPoint.y - (self.viewOrigin!.y)
                },
                completion: { _ in
                    self.parentView.insertSubview(self.cardStackView, at: (self.cardInformation?.indexes.xIndex)!)
                    self.mainView.isUserInteractionEnabled = true
                }
            )
        }
    }

}
