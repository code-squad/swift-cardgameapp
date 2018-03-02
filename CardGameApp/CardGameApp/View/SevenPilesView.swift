//
//  CardPileView.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 1. 30..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class SevenPilesView: UIView {
    private var sevenPiles = [CardPileView]() {
        didSet {
            setNeedsDisplay()
        }
    }

    func push(card: CardView, xIndex: Int) {
        sevenPiles[xIndex].addSubview(card)
    }

    func pop(xIndex: Int) {
        sevenPiles[xIndex].pop()
    }
}
