//
//  DragController.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 3. 19..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class DragController {
    private var viewOrigin: CGPoint?
    private let original: OriginalInformation
    private var dropableInformations: [DropableInformation]?
    private var targetParentModel: Receivable?

    init?(original: OriginalInformation) {
        self.original = original
    }

    private func moveCardModel(from cardIndexes: CardIndexes, to target: CardIndexes) {
        _ = targetParentModel?.push(cards: (original.originParentModel?.pop(indexes: cardIndexes))!, indexes: target)
    }

    private func checkFinished() {
        if let targetModel = targetParentModel as? FoundationsViewModel, targetModel.isSuccess() {
            NotificationCenter.default.post(name: .success, object: self, userInfo: nil)
        }
    }

    func setViewOrigin(at viewOrigin: CGPoint) {
        self.viewOrigin = viewOrigin
    }

    // state : .began
    func dragBegan() {
        original.animationBegan()
        guard original.cardInformation != nil else { return }
        let targetInformation = TargetInformation(of: original.cardInformation!.card)
        dropableInformations = targetInformation.availableInformations
        guard dropableInformations != nil, dropableInformations!.count > 0 else { return }
    }

    // state : .changed
    func dragChanged(with recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: original.cardView)
        for targetView in original.cardPackForDragging {
            dragChanged(targetView: targetView, with: translation)
        }
        recognizer.setTranslation(CGPoint.zero, in: original.mainView)
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
        for dropableInformation in dropableInformations! {
            setTargetParent(dropableInformation: dropableInformation)
            if dropCards(on: dropableInformation, at: fingerLocation) { return true }
        }
        return false
    }
    private func setTargetParent(dropableInformation: DropableInformation) {
        targetParentModel = dropableInformation.targetParent
    }
    private func dropCards(on dropableInformation: DropableInformation, at fingerLocation: CGPoint) -> Bool {
        for cardIndexes in dropableInformation.availableIndexes {
            let targetRect = getTargetRect(of: cardIndexes)
            if targetRect.contains(fingerLocation) {
                moveWithDragging(to: cardIndexes)
                return true
            }
        }
        return false
    }
    private func getTargetRect(of cardIndexes: CardIndexes) -> CGRect {
        let rectX = original.cardView.frame.width * CGFloat(cardIndexes.xIndex)
        let rectY = getRectOriginY(cardIndexes: cardIndexes)
        return CGRect(origin: CGPoint(x: rectX, y: rectY), size: original.cardView.frame.size)
    }
    private func getRectOriginY(cardIndexes: CardIndexes) -> CGFloat {
        return targetParentModel is FoundationsViewModel ? CGFloat(Figure.YPosition.topMargin.value)
                               : CGFloat(Figure.YPosition.cardPileTopMargin.value
                                 + Figure.YPosition.betweenCards.value * cardIndexes.yIndex)
    }
    private func moveWithDragging(to cardIndexes: CardIndexes) {
        original.animationCompletion()
        moveCardModel(from: original.cardInformation!.indexes, to: cardIndexes)
    }
    private func moveBackToOrigin() {
        let globalPoint = original.cardStackView.convert(original.cardView.frame.origin, to: nil)
        original.mainView.isUserInteractionEnabled = false
        for index in original.cardPackForDragging.indices {
            UIViewPropertyAnimator.runningPropertyAnimator(
                withDuration: 0.5,
                delay: 0.0,
                options: [.curveLinear],
                animations: {
                    self.original.cardPackForDragging[index].frame.origin.x -= globalPoint.x - (self.viewOrigin!.x)
                    self.original.cardPackForDragging[index].frame.origin.y -= globalPoint.y - (self.viewOrigin!.y)
                },
                completion: { _ in
                    self.original.animationCompletion()
                    self.original.mainView.isUserInteractionEnabled = true
                }
            )
        }
    }
}
