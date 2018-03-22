//
//  MovableCardView.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 14..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class MovableCardView {
    weak var delegate: CanUpdateViewModel?
    private(set) var cardView: CardView
    private(set) var fromLocation: Location
    private(set) var toLocation: Location
    private(set) var startPoint: CGPoint
    private(set) var endPoint: CGPoint

    init() {
        self.cardView = CardView()
        self.startPoint = CGPoint()
        self.endPoint = CGPoint()
        fromLocation = .spare
        toLocation = .spare
    }

    init(cardView: CardView,
         from fromLocation: Location, to toLocation: Location,
         startPoint: CGPoint, endPoint: CGPoint) {
        self.cardView = cardView
        self.fromLocation = fromLocation
        self.toLocation = toLocation
        self.startPoint = startPoint
        self.endPoint = endPoint
    }

    func animateToMove() {
        let translateTransform =
            self.cardView.transform.translatedBy(x: endPoint.x-startPoint.x, y: endPoint.y-startPoint.y)
        UIView.animate(withDuration: 0.5, animations: { [unowned self] in
            // 현재 이동중인 카드를 맨 앞으로.
            self.cardView.bringFront()
            self.cardView.transform = translateTransform
        }, completion: { _ in
            // 모델 변경
            self.delegate?.updateMovedCards(movableCardView: self)
        })
    }

}
