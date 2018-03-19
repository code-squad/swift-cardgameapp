//
//  DragAction.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 3. 13..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

typealias AttachableInformation = (targetParentView: UIStackView, cardIndexes: [CardIndexes])
class MoveController {
    // view's original frame origin when it is dragging
    private var viewOrigin: CGPoint?
    // views
    private let cardView: CardView
    private let cardStackView: CardStackView
    private let parentView: UIStackView
    private let mainView: UIView
    // dragged cards information
    private var cardInformation: CardInformation?
    private var cardPackForDragging: [CardView]
    private var originParentModel: Sendable?
    // target information
    private var isToFoundations: Bool = true
    private var dropableInformations: [DropableInformation]?
    private var attachableInformations: [AttachableInformation] = []
    private var targetParentModel: Receivable? {
        didSet {
            if targetParentModel is SevenPilesViewModel {
                isToFoundations = false
            } else {
                isToFoundations = true
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

    func setViewOrigin(at viewOrigin: CGPoint) {
        self.viewOrigin = viewOrigin
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

    private func getTargetParentModel(card: Card) -> Receivable? {
        return Target.getParent(of: card)
    }

    private func setCardPackForDragging() {
        for index in (cardInformation?.indexes.yIndex)!..<cardStackView.subviews.count {
            guard let card = cardStackView.subviews[index] as? CardView else { continue }
            self.cardPackForDragging.append(card)
        }
    }

    private func moveCardModel(from cardIndexes: CardIndexes, to target: CardIndexes) {
        _ = targetParentModel?.push(cards: (originParentModel?.pop(indexes: cardIndexes))!, indexes: target)
    }

    private func checkFinished() {
        if let targetModel = targetParentModel as? FoundationsViewModel, targetModel.isSuccess() {
            NotificationCenter.default.post(name: .success, object: self, userInfo: nil)
        }
    }

}

// MARK: Double Tap
extension MoveController {
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
                self.moveCardModel(from: self.cardInformation!.indexes, to: target)
                self.checkFinished()
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
}

// MARK: Drag & Drop
extension MoveController {
    // state : .began
    func dragBegan() {
        mainView.bringSubview(toFront: parentView)
        parentView.bringSubview(toFront: cardStackView)
        guard cardInformation != nil else { return }
        dropableInformations = Target.availableInformations(of: cardInformation!.card)
        guard dropableInformations != nil, dropableInformations!.count > 0 else { return }
        for dropableInformation in dropableInformations! {
            addAttachableInformation(with: dropableInformation)
        }
    }
    private func addAttachableInformation(with dropableInformation: DropableInformation) {
        guard let targetParentView = getTargetParentView(of: dropableInformation.targetParent) else { return }
        attachableInformations.append((targetParentView: targetParentView,
                                       cardIndexes: dropableInformation.availableIndexes))
    }
    private func getTargetParentView(of targetParentModel: Receivable) -> UIStackView? {
        guard let foundationsView = mainView.subviews[0] as? UIStackView else { return nil }
        guard let sevenPilesView = mainView.subviews[3] as? UIStackView else { return nil }
        return targetParentModel is FoundationsView ? foundationsView : sevenPilesView
    }

    // state : .changed
    func dragChanged(with recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: cardView)
        for targetView in cardPackForDragging {
            dragChanged(targetView: targetView, with: translation)
        }
        recognizer.setTranslation(CGPoint.zero, in: mainView)
    }
    private func dragChanged(targetView: CardView, with translation: CGPoint) {
        targetView.center = CGPoint(x: targetView.center.x + translation.x,
                                    y: targetView.center.y + translation.y)
    }

    // state : .ended
    func dragEnded(at fingerLocation: CGPoint) {
        if dragged(at: fingerLocation) {
            checkFinished()
        } else {
            moveBackToOrigin()
        }
    }
    private func dragged(at fingerLocation: CGPoint) -> Bool {
        for attachableInformation in attachableInformations {
            setTargetParent(parentView: attachableInformation.targetParentView)
            if dropCards(on: attachableInformation, at: fingerLocation) { return true }
        }
        return false
    }
    private func setTargetParent(parentView: UIStackView) {
        parentView is FoundationsView ? setTargetToFoundations() : setTargetToSevenPiles()
    }
    private func setTargetToFoundations() {
        targetParentModel = FoundationsViewModel.sharedInstance()
        isToFoundations = true
    }
    private func setTargetToSevenPiles() {
        targetParentModel = SevenPilesViewModel.sharedInstance()
        isToFoundations = false
    }
    private func dropCards(on attachableInformation: AttachableInformation, at fingerLocation: CGPoint) -> Bool {
        for cardIndexes in attachableInformation.cardIndexes {
            let targetRect = getTargetRect(of: cardIndexes)
            if targetRect.contains(fingerLocation) {
                moveWithDragging(to: cardIndexes)
                return true
            }
        }
        return false
    }
    private func getTargetRect(of cardIndexes: CardIndexes) -> CGRect {
        let rectX = cardView.frame.width * CGFloat(cardIndexes.xIndex)
        let rectY = getRectOriginY(cardIndexes: cardIndexes)
        return CGRect(origin: CGPoint(x: rectX, y: rectY), size: cardView.frame.size)
    }
    private func getRectOriginY(cardIndexes: CardIndexes) -> CGFloat {
        return isToFoundations ? CGFloat(Figure.YPosition.topMargin.value)
                               : CGFloat(Figure.YPosition.cardPileTopMargin.value +
                                         Figure.YPosition.betweenCards.value * cardIndexes.yIndex)
    }
    private func moveWithDragging(to cardIndexes: CardIndexes) {
        parentView.insertSubview(cardStackView, at: cardInformation!.indexes.xIndex)
        moveCardModel(from: cardInformation!.indexes, to: cardIndexes)
    }
    private func moveBackToOrigin() {
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
                    self.parentView.insertSubview(self.cardStackView,
                                                  at: (self.cardInformation?.indexes.xIndex)!)
                    self.mainView.isUserInteractionEnabled = true
                }
            )
        }
    }
}
