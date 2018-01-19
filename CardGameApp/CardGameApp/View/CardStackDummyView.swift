//
//  CardStacksView.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 28..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

class CardStackDummyView: UIStackView {

    weak var delegate: CardStackDummyViewDelegate?
    var dragInfo: DragInfo!
    enum Direction {
        case cardDummy
        case cardStackDummy
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func setCardStackDummyView(_ cardStacks: [CardStack]) {
        addCardStackViews(cardStacks)
    }

    private func addCardStackViews(_ cardStacks: [CardStack]) {
        var i = 0
        subviews.forEach {
            let cardStack = cardStacks[i]
            guard let stackview = $0 as? CardStackView else { return }
            stackview.setCardStackImageView(cardStack)
            stackview.addDoubleTapGestureAllSubViews(action: Action(target: self, selector: #selector(self.cardViewDidDoubleTap(_:))))
            stackview.addPanGesture(action: Action(target: self, selector: #selector(self.drag(_:))))
            stackview.validUserInterationOnlyLastCard()
            i += 1
        }
    }

    func removeCardStackDummyView() {
        subviews.forEach {
            guard let stackview = $0 as? CardStackView else { return }
            stackview.removeAllCardViews()
        }
    }

    func moveX(from startIndex: Int, to targetIndex: Int) -> CGFloat {
        let startX = subviews[startIndex].frame.origin.x
        let targetX = subviews[targetIndex].frame.origin.x
        return targetX - startX
    }

    func moveY(from startIndex: Int, to targetIndex: Int) -> CGFloat {
        guard let startCardStackview = subviews[startIndex] as? CardStackView,
            let targetCardStackview = subviews[targetIndex] as? CardStackView else {
            return CGFloat(0)
        }
        let nextY = targetCardStackview.topConstantOfLastCard() + 30
        return nextY - startCardStackview.topConstantOfLastCard()
    }

    func movePoint(from startIndex: Int, to targetIndex: Int) -> CGPoint {
        let x = moveX(from: startIndex, to: targetIndex)
        let y = moveY(from: startIndex, to: targetIndex)
        return CGPoint(x: x, y: y)
    }
    // get view position

    // x좌표를 갖고 현재 위치가 몇번 째 카드 스택에 속하는지 인덱스 반환.
    private func currentIndex(pointX: CGFloat) -> Int {
        let dummyViewFrame = self.frame
        let distributionWidth = dummyViewFrame.width / 7
        return Int(pointX / distributionWidth)
    }

    func topConstantOfLastCard(in cardStackView: UIView) -> CGFloat {
        let cardStackView = cardStackView as? CardStackView
        let lastCardOriginY = cardStackView?.topConstantOfLastCard() ?? 0
        return lastCardOriginY
    }

    func targetY(translateY: CGFloat, targetIndex: Int) -> Bool {
        guard let cardStackView = subviews[targetIndex] as? CardStackView else {return false}
        return cardStackView.targetY(translateY: translateY, targetIndex: targetIndex)
    }
}

extension CardStackDummyView: CardStackMovableView {
    func pop(index: Int, previousCard: Card?) {
        let cardStackview = subviews[index] as? CardStackView
        cardStackview?.popCardStackView(previousCard: previousCard)
    }

    func push(index: Int, cardViews: [CardView]) {
        let cardStackview = subviews[index] as? CardStackView
        cardViews.forEach {
            cardStackview?.pushCardStackView(cardView: $0)
            $0.addTapGesture(
                action: Action(target: self, selector: #selector(self.cardViewDidDoubleTap(_:))),
                numberOfTapsRequired: 2
            )
            $0.addPanGesture(action: Action(target: self, selector: #selector(self.drag(_:))))
        }

    }
}

// MARK: Events
extension CardStackDummyView {
    @objc func cardViewDidDoubleTap(_ sender: UITapGestureRecognizer) {
        let tappedLocation = sender.location(in: self)
        let indexTapped = currentIndex(pointX: tappedLocation.x)
        guard let tappedView = sender.view as? CardView,
            topConstantOfLastCard(in: subviews[indexTapped]) == tappedView.frame.origin.y,
            let delegate = self.delegate else {
                return
        }
        guard let moveXY = delegate.pointOfCardDummyView(startIndex: indexTapped) else { return }
        UIView.animate(
            withDuration: 0.5,
            animations: {
                tappedView.frame.origin.x += moveXY.x
                tappedView.frame.origin.y += moveXY.y

        },
            completion: { _ in
                delegate.moveCardViews(tappedView: tappedView, startIndex: indexTapped)
        })
    }

    @objc func drag(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            dragInfo = DragInfo()
            let tappedLocation = gesture.location(in: self)
            dragInfo.startStackIndex = currentIndex(pointX: tappedLocation.x)
            guard let view = gesture.view as? CardView else { return }
            guard let stackView = view.superview as? CardStackView else { return }
            dragInfo.changes = stackView.belowViews(with: view)
            //self.bringSubview(toFront: stackView)
            dragInfo.changes.forEach {
                dragInfo.originals.append($0.center)
            }
        case .changed:
            dragInfo.changes.forEach {
                let translation = gesture.translation(in: self)
                $0.center = CGPoint(
                    x: $0.center.x + translation.x,
                    y: $0.center.y + translation.y)
            }
            gesture.setTranslation(CGPoint.zero, in: self)
        case .ended:
            let targetLocation = gesture.location(in: self)
            guard let view = gesture.view as? CardView else { return }
            dragInfo.targetStackIndex = currentIndex(pointX: targetLocation.x)
            if targetY(translateY: view.frame.origin.y, targetIndex: dragInfo.targetStackIndex) {
                delegate?.moveToCardStackDummyView(
                    tappedView: dragInfo.changes,
                    startIndex: dragInfo.startStackIndex,
                    targetIndex: dragInfo.targetStackIndex
                )
            }
            var i = 0
            dragInfo.changes.forEach {
                $0.center.x = dragInfo.originals[i].x
                $0.center.y = dragInfo.originals[i].y
                i += 1
            }

            dragInfo = nil
        default: break
        }
    }
}

extension CardStackDummyView: UIGestureRecognizerDelegate {
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
        ) -> Bool {
        return true
    }
}

protocol CardStackDummyViewDelegate: NSObjectProtocol {
    func moveCardViews(tappedView: UIView, startIndex: Int)
    func moveToCardStackDummyView(tappedView: [UIView], startIndex: Int, targetIndex: Int)
    func pointOfCardDummyView(startIndex: Int) -> CGPoint?
}
