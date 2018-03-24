//
//  TableauView.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 3. 23..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class TableauView: UIView, CanLayCards {
    private var index: Int
    private let emptyView: EmptyView
    private var laidCards: [CardView] = []
    private let verticalSpacing: CGFloat

    private var config: ViewConfig

    init(frame: CGRect, index: Int, config: ViewConfig) {
        emptyView = EmptyView(frame: CGRect(origin: .zero, size: config.cardSize))
        self.index = index
        self.config = ViewConfig(on: UIView())
        self.verticalSpacing = config.cardSize.height*0.3
        super.init(frame: frame)
        addSubview(emptyView)
    }

    required init?(coder aDecoder: NSCoder) {
        index = 0
        emptyView = EmptyView(frame: .zero)
        verticalSpacing = 0
        config = ViewConfig(on: UIView())
        super.init(coder: aDecoder)
    }

    func lay(card: CardView) {
        laidCards.append(card)
//        addSubview(card)
    }

    func removeLastCard() {
        laidCards.isEmpty ? nil : laidCards.removeLast()
//        laidCards.last?.removeFromSuperview()
    }

    func reset() {
        laidCards = []
    }

    func removeAllSubviews() {
        laidCards = []
        laidCards.forEach { $0.removeFromSuperview() }
    }

    func nextCardPosition() -> CGPoint {
        let basePosition = self.frame.origin
        return CGPoint(x: basePosition.x,
                       y: basePosition.y+CGFloat(laidCards.count)*verticalSpacing)
    }
}
