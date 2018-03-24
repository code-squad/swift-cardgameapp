//
//  WasteView.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 3. 23..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class WasteView: UIView, Sequence, CanLayCards {
    private let emptyView: EmptyView
    private var laidCards: [CardView] = []
    let start: Int = 0

    func makeIterator() -> ClassIteratorOf<CardView> {
        return ClassIteratorOf(self.laidCards)
    }

    override init(frame: CGRect) {
        emptyView = EmptyView(frame: CGRect(origin: .zero, size: frame.size), hasBorder: false)
        super.init(frame: frame)
        addSubview(emptyView)
    }

    required init?(coder aDecoder: NSCoder) {
        emptyView = EmptyView(frame: .zero)
        super.init(coder: aDecoder)
    }

    func nextCardPosition() -> CGPoint? {
        return self.frame.origin
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
}
