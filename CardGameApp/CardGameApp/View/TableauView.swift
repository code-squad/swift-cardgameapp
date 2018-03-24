//
//  TableauView.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 3. 23..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class TableauView: UIView, CanLayCards, CanFindGameView {
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
    }

    func removeLastCard() {
        _ = laidCards.isEmpty ? nil : laidCards.removeLast()
    }

    func reset() {
        laidCards = []
    }

    func removeAllSubviews() {
        laidCards.forEach { $0.removeFromSuperview() }
        laidCards = []
    }

    func nextCardPosition() -> CGPoint? {
        var basePosition: CGPoint?
        handleCertainView(from: self) { gameView in
            basePosition = convert(self.frame.origin, to: gameView)
        }
        return CGPoint(x: basePosition!.x/2, y: basePosition!.y+CGFloat(laidCards.count)*verticalSpacing)
    }
}
