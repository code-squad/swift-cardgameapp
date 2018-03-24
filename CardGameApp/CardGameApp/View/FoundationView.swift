//
//  FoundationView.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 3. 23..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class FoundationView: UIView, CanLayCards {
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
//        addSubview(card)
    }

    func removeLastCard() {
        laidCards.isEmpty ? nil : laidCards.removeLast()
//        laidCards.last?.removeFromSuperview()
    }

    func removeAllSubviews() {
        laidCards = []
        laidCards.forEach { $0.removeFromSuperview() }
    }

    func nextCardPosition() -> CGPoint {
        return self.frame.origin
    }
}
