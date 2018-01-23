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

    func setCardStackDummyView(_ cardStacks: [CardStack]) {
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
}

extension CardStackDummyView: MovableView {
    // 점이 속한 뷰의 스택 인덱스, 카드 인덱스 반환
    func position(_ point: CGPoint) -> Position? {
        let dummyViewFrame = self.frame
        let distributionWidth = dummyViewFrame.width / Size.cardStackCount.cgfloat
        let stackIndex = Int(point.x / distributionWidth)
        guard let cardStackView = subviews[stackIndex] as? CardStackView,
            let cardIndex = cardStackView.cardIndex(pos: point) else { return nil }
        return Position(stackIndex: stackIndex, cardIndex: cardIndex)
    }

    // 특정 스택 인덱스, 카드 인덱스에 해당되는 카드 뷰 반환
    func selectedView(_ position: Position) -> CardView? {
        let stackView = subviews[position.stackIndex] as? CardStackView
        return stackView?.selectedCardView(index: position.cardIndex)
    }

    // 특정 스택 인덱스, 카드 인덱스에 해당되는 카드 뷰가 마지막 뷰인지 여부 반환
    func isLast(_ position: Position) -> Bool {
        guard let cardStackView = subviews[position.stackIndex] as? CardStackView else {return false}
        return cardStackView.isLastCard(index: position.cardIndex)
    }

    // 특정 스택 인덱스, 카드 인덱스를 비롯한 아래에 위치한 카드 뷰 배열 반환
    func belowViews(_ position: Position) -> [UIView] {
        guard let cardStackView = subviews[position.stackIndex] as? CardStackView else { return [] }
        return cardStackView.belowViews(index: position.cardIndex)
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

    // 해당 카드 인덱스의 마지막 카드 뷰 Origin 좌표
    func coordinate(index: Int) -> CGPoint {
        let x = Size.spacing*(index.cgfloat+1) + Size.cardWidth*index.cgfloat
        var y = Size.statusBarHeight + Size.cardHeight + Size.topConstantOfCardStack
        let carStackView = subviews[index] as? CardStackView
        guard let lastCardView = carStackView?.lastCard as? CardView else {
            return CGPoint(x: x, y: y)
        }
        y += lastCardView.frame.origin.y
        return CGPoint(x: x, y: y)
    }

    // 해당 카드 인덱스의 마지막 카드 뷰 다음에 위치할 카드 뷰의 Origin 좌표
    func targetCoordinate(index: Int) -> CGPoint {
        var point = coordinate(index: index)
        let carStackView = subviews[index] as? CardStackView
        guard carStackView?.lastCard is CardView else {
            return point
        }
        point.y += Size.topConstantOfCardInCardStack
        return point
    }

}
