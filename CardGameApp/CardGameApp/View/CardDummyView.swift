//
//  CardDummyView.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 12..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

class CardDummyView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func removeAllCardDummy() {
        self.subviews.forEach { (view: UIView) in
            view.subviews.forEach {
                $0.removeFromSuperview()
            }
        }
    }
}

extension CardDummyView: MovableView {
    func targetCoordinate(index: Int) -> CGPoint {
        return coordinate(index: index)
    }

    func isLast(_ position: Position) -> Bool {
        return true
    }

    func belowViews(_ position: Position) -> [UIView] {
        return []
    }

    // 점이 속한 뷰의 스택 인덱스, 카드 인덱스 반환
    func position(_ point: CGPoint) -> Position? {
        for i in 0..<subviews.count {
            var frame = CGRect(origin: CGPoint.zero, size: CGSize(width: Size.cardWidth, height: Size.cardHeight))
            let coor = coordinate(index: i)
            frame.origin.x += coor.x
            frame.origin.y += coor.y
            if frame.contains(point) { return Position(stackIndex: i, cardIndex: 0) }
        }
        return nil
    }

    func selectedView(_ position: Position) -> CardView? {
        return nil
    }

    func destination(_ point: CGPoint) -> Int? {
        for i in 0..<subviews.count {
            var frame = CGRect(origin: CGPoint.zero, size: CGSize(width: Size.cardWidth, height: Size.cardHeight))
            let coor = coordinate(index: i)
            frame.origin.x += coor.x
            frame.origin.y += coor.y
            if frame.contains(point) { return i }
        }
        return nil
    }

    func coordinate(index: Int) -> CGPoint {
        return CGPoint(x: Size.spacing*(index.cgfloat+1) + Size.cardWidth*index.cgfloat, y: Size.statusBarHeight)
    }
    func pop(index: Int, previousCard: Card?) {
        // Not yet
    }

    func push(index: Int, cardViews: [CardView]) {
        cardViews.forEach {
            subviews[index].addSubview($0)
            $0.fitLayout(with: subviews[index])
            $0.isUserInteractionEnabled = false
        }
    }
}
