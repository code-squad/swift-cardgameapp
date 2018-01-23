//
//  CardStacksView.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 28..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

class CardStackDummyView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func position(pos: CGPoint) -> Position? {
        let dummyViewFrame = self.frame
        let distributionWidth = dummyViewFrame.width / 7
        let stackIndex = Int(pos.x / distributionWidth)
        guard let cardStackView = subviews[stackIndex] as? CardStackView,
            let cardIndex = cardStackView.cardIndex(pos: pos) else { return nil }
        return Position(stackIndex: stackIndex, cardIndex: cardIndex)
    }

    func selectedView(pos: Position) -> CardView? {
        let stackView = subviews[pos.stackIndex] as? CardStackView
        return stackView?.selectedCardView(index: pos.cardIndex)
    }

    func addDoubleTapGesture(action: Action) {
        let tapRecognizer = UITapGestureRecognizer(
            target: action.target, action: action.selector)
        tapRecognizer.numberOfTapsRequired = 2
        self.addGestureRecognizer(tapRecognizer)
        self.isUserInteractionEnabled = true
    }

    func addPangesture(action: Action) {
        let panRecognizer = UIPanGestureRecognizer(
            target: action.target, action: action.selector)
        self.addGestureRecognizer(panRecognizer)
        self.isUserInteractionEnabled = true
    }

    func setCardStackDummyView(_ cardStacks: [CardStack]) {
        addCardStackViews(cardStacks)
    }

    private func addCardStackViews(_ cardStacks: [CardStack]) {
        var i = 0
        subviews.forEach {
            let cardStack = cardStacks[i]
            guard let stackView = $0 as? CardStackView else { return }
            stackView.setCardStackImageView(cardStack)
            i += 1
        }
    }

    func removeCardStackDummyView() {
        subviews.forEach {
            guard let stackview = $0 as? CardStackView else { return }
            stackview.removeAllCardViews()
        }
    }

    // get view position

    // x좌표를 갖고 현재 위치가 몇번 째 카드 스택에 속하는지 인덱스 반환.
    func currentIndex(pointX: CGFloat) -> Int {
        let dummyViewFrame = self.frame
        let distributionWidth = dummyViewFrame.width / 7
        return Int(pointX / distributionWidth)
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

    func topConstantOfLastCard(in index: Int) -> CGFloat {
        let cardStackView = subviews[index] as? CardStackView
        let lastCardOriginY = cardStackView?.topConstantOfLastCard() ?? 0
        return lastCardOriginY
    }

    func targetY(translateY: CGFloat, targetIndex: Int) -> Bool {
        guard let cardStackView = subviews[targetIndex] as? CardStackView else {return false}
        return cardStackView.targetY(translateY: translateY, targetIndex: targetIndex)
    }
}

extension CardStackDummyView: MovableView {
    func isLast(pos: Position) -> Bool {
        guard let cardStackView = subviews[pos.stackIndex] as? CardStackView else {return false}
        return cardStackView.isLastCard(index: pos.cardIndex)
    }

    func belowViews(pos: Position) -> [UIView]? {
        guard let cardStackView = subviews[pos.stackIndex] as? CardStackView else {return nil}
        return cardStackView.belowViews(index: pos.cardIndex)
    }

    func pop(index: Int, previousCard: Card?) {
        let cardStackview = subviews[index] as? CardStackView
        cardStackview?.popCardStackView(previousCard: previousCard)
    }

    func push(index: Int, cardViews: [CardView]) {
        guard let cardStackview = subviews[index] as? CardStackView else {
            return
        }
        cardViews.forEach { cardStackview.pushCardStackView(cardView: $0) }
    }

    func coordinate(index: Int) -> CGPoint? {
        let x = 3*(index.cgfloat+1) + Size.cardWidth*index.cgfloat
        var y = Size.statusBarHeight + Size.cardHeight + 7.5
        let carStackView = subviews[index] as? CardStackView
        guard let lastCardView = carStackView?.lastCard() else {
            return CGPoint(x: x, y: y)
        }
        y += lastCardView.frame.origin.y
        return CGPoint(x: x, y: y)
    }

    func targetCoordinate(index: Int) -> CGPoint? {
        let x = 3*(index.cgfloat+1) + Size.cardWidth*index.cgfloat
        var y = Size.statusBarHeight + Size.cardHeight + 7.5
        let carStackView = subviews[index] as? CardStackView
        guard let lastCardView = carStackView?.lastCard() else {
            return CGPoint(x: x, y: y)
        }
        y += lastCardView.frame.origin.y
        return CGPoint(x: x, y: y + 30)

    }

}
