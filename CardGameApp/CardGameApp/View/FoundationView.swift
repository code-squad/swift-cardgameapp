//
//  FoundationView.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 3. 23..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class FoundationView: UIView, CanLayCards, CanFindGameView {
    private var index: Int
    private let emptyView: EmptyView
    private var laidCards: [CardView] = []

    convenience init(frame: CGRect, index: Int) {
        self.init(frame: frame)
        self.index = index
    }

    override init(frame: CGRect) {
        index = 0
        emptyView = EmptyView(frame: CGRect(origin: .zero, size: frame.size))
        super.init(frame: frame)
        addSubview(emptyView)
    }

    required init?(coder aDecoder: NSCoder) {
        index = 0
        emptyView = EmptyView(frame: .zero)
        super.init(coder: aDecoder)
    }

    func lay(card: CardView) {
        laidCards.append(card)
    }

    func removeLastCard() {
        _ = laidCards.isEmpty ? nil : laidCards.removeLast()
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
        return CGPoint(x: basePosition!.x/2, y: basePosition!.y)
    }
}
