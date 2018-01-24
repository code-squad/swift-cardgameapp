//
//  TableauPilesView.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 28..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

class TableauPilesView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func setTableauPilesView(_ cardStacks: [CardStack]) {
        var i = 0
        subviews.forEach {
            let cardStack = cardStacks[i]
            guard let tableauView = $0 as? TableauView else { return }
            tableauView.setTableaImageView(cardStack)
            i += 1
        }
    }

    func removeTableauPilesView() {
        subviews.forEach {
            guard let tableauView = $0 as? TableauView else { return }
            tableauView.removeAllCardViews()
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

extension TableauPilesView: MovableView {
    // 점이 속한 뷰의 스택 인덱스, 카드 인덱스 반환
    func position(_ point: CGPoint) -> Position? {
        let tableauPilesViewFrame = self.frame
        let distributionWidth = tableauPilesViewFrame.width / Size.cardStackCount.cgfloat
        let tableauIndex = Int(point.x / distributionWidth)
        guard let tableauView = subviews[tableauIndex] as? TableauView,
            let cardIndex = tableauView.cardIndex(pos: point) else { return nil }
        return Position(stackIndex: tableauIndex, cardIndex: cardIndex)
    }

    // 특정 스택 인덱스, 카드 인덱스에 해당되는 카드 뷰 반환
    func selectedView(_ position: Position) -> CardView? {
        let tableauView = subviews[position.stackIndex] as? TableauView
        return tableauView?.selectedCardView(index: position.cardIndex)
    }

    // 특정 스택 인덱스, 카드 인덱스에 해당되는 카드 뷰가 마지막 뷰인지 여부 반환
    func isLast(_ position: Position) -> Bool {
        guard let tableauView = subviews[position.stackIndex] as? TableauView else {return false}
        return tableauView.isLastCard(index: position.cardIndex)
    }

    // 특정 스택 인덱스, 카드 인덱스를 비롯한 아래에 위치한 카드 뷰 배열 반환
    func belowViews(_ position: Position) -> [UIView] {
        guard let tableauView = subviews[position.stackIndex] as? TableauView else { return [] }
        return tableauView.belowViews(index: position.cardIndex)
    }

    func pop(index: Int, previousCard: Card?) {
        let tableauView = subviews[index] as? TableauView
        tableauView?.popCardStackView(previousCard: previousCard)
    }

    func push(index: Int, cardViews: [CardView]) {
        guard let tableauView = subviews[index] as? TableauView else {
            return
        }
        cardViews.forEach { tableauView.pushCardStackView(cardView: $0) }
    }

    // 해당 카드 인덱스의 마지막 카드 뷰 Origin 좌표
    func coordinate(index: Int) -> CGPoint {
        let x = Size.spacing*(index.cgfloat+1) + Size.cardWidth*index.cgfloat
        var y = Size.statusBarHeight + Size.cardHeight + Size.topConstantOfCardStack
        let tableauView = subviews[index] as? TableauView
        guard let lastCardView = tableauView?.lastCard as? CardView else {
            return CGPoint(x: x, y: y)
        }
        y += lastCardView.frame.origin.y
        return CGPoint(x: x, y: y)
    }

    // 해당 카드 인덱스의 마지막 카드 뷰 다음에 위치할 카드 뷰의 Origin 좌표
    func targetCoordinate(index: Int) -> CGPoint {
        var point = coordinate(index: index)
        let tableauView = subviews[index] as? TableauView
        guard tableauView?.lastCard is CardView else {
            return point
        }
        point.y += Size.topConstantOfCardInCardStack
        return point
    }

}
