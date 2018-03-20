//
//  DragAction.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 3. 13..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class MoveController {
    private var targetPoint: CGPoint?
    private let original: OriginalInformation
    private var dropableInformations: [DropableInformation]?
    private var targetParentModel: Receivable?

    init?(original: OriginalInformation) {
        self.original = original
    }

    func setTargetPoint(at targetPoint: CGPoint) {
        self.targetPoint = targetPoint
    }
}

// MARK: Common Logic
extension MoveController {
    private func move(to target: CGPoint, cardIndexes: CardIndexes, isBack: Bool) {
        let globalPoint = original.cardStackView.convert(original.cardView.frame.origin, to: nil)
        original.mainView.isUserInteractionEnabled = false
        for index in original.cardPackForDragging.indices {
            UIViewPropertyAnimator.runningPropertyAnimator(
                withDuration: 0.5,
                delay: 0.0,
                options: [.curveLinear],
                animations: {
                    self.original.cardPackForDragging[index].frame.origin.x -= globalPoint.x - target.x
                    self.original.cardPackForDragging[index].frame.origin.y -= globalPoint.y - target.y
                },
                completion: { _ in
                    self.original.animationCompletion()
                    if !isBack {
                        self.moveCardModel(from: self.original.cardInformation!.indexes, to: cardIndexes)
                    }
                    self.original.mainView.isUserInteractionEnabled = true
                }
            )
        }
    }

    private func moveCardModel(from cardIndexes: CardIndexes, to target: CardIndexes) {
        _ = targetParentModel?.push(cards: (original.originParentModel?.pop(indexes: cardIndexes))!, indexes: target)
    }

    private func checkFinished() {
        if let targetModel = targetParentModel as? FoundationsViewModel, targetModel.isSuccess() {
            NotificationCenter.default.post(name: .success, object: self, userInfo: nil)
        }
    }
}

// MARK: DoubleTap
extension MoveController {
    func doubleTap() {
        guard original.isDoubleTapable() else { return }
        dragBegan()
        dragEnded(at: nil)
    }
}

// MARK: Drag & Drop
extension MoveController {
    // state : .began
    func dragBegan() {
        guard original.cardInformation != nil else { return }
        let targetInformation = TargetInformation(of: original.cardInformation!.card)
        dropableInformations = targetInformation.availableInformations
        guard dropableInformations != nil, dropableInformations!.count > 0 else { return }
        original.animationBegan()
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
    func dragEnded(at fingerLocation: CGPoint?) {
        if moved(at: fingerLocation) {
            checkFinished()
        } else {
            move(to: targetPoint!, cardIndexes: (original.cardInformation?.indexes)!, isBack: true)
        }
    }
    private func moved(at fingerLocation: CGPoint?) -> Bool {
        for dropableInformation in dropableInformations! {
            setTargetParent(dropableInformation: dropableInformation)
            if dropCards(on: dropableInformation, at: fingerLocation) { return true }
        }
        return false
    }
    private func setTargetParent(dropableInformation: DropableInformation) {
        targetParentModel = dropableInformation.targetParent
    }
    private func dropCards(on dropableInformation: DropableInformation, at fingerLocation: CGPoint?) -> Bool {
        for cardIndexes in dropableInformation.availableIndexes {
            let targetRect = getTargetRect(of: cardIndexes)
            if let finger = fingerLocation {
                if targetRect.contains(finger) {
                    move(to: targetRect.origin, cardIndexes: cardIndexes, isBack: false)
                    return true
                }
            } else { // doubleTap
                move(to: targetRect.origin, cardIndexes: cardIndexes, isBack: false)
                return true
            }
        }
        return false
    }
    private func getTargetRect(of cardIndexes: CardIndexes) -> CGRect {
        let rectX = (original.mainView.frame.width / CGFloat(Figure.Size.countInRow.value))
                    * CGFloat(cardIndexes.xIndex) + CGFloat(Figure.Size.xGap.value)
        let rectY = getRectOriginY(cardIndexes: cardIndexes)
        return CGRect(origin: CGPoint(x: rectX, y: rectY), size: original.cardView.frame.size)
    }
    private func getRectOriginY(cardIndexes: CardIndexes) -> CGFloat {
        return targetParentModel is FoundationsViewModel ? CGFloat(Figure.YPosition.topMargin.value)
                                : CGFloat(Figure.YPosition.cardPileTopMargin.value
                                  + Figure.YPosition.betweenCards.value * cardIndexes.yIndex)
    }
}
