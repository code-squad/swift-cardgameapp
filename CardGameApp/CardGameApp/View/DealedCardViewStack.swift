//
//  DealedCardStackView.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 4..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class DealedCardViewStack: CardViewStack {
    override var dataSource: CardViewStackDataSource? {
        didSet {
            self.setupCardImages()
        }
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(frame: CGRect, cardViews: [CardView], spacing: CGFloat, bottomMargin: CGFloat) {
        self.init(frame: frame)
        setupCardViews(cardViews)
        let stackViewInfo = StackViewInfo(axis: .vertical,
                                          distribution: .fill,
                                          spacing: spacing,
                                          bottomMargin: bottomMargin)
        stackSettings(stackViewInfo)
    }

    func setupCardImages() {
        guard let subCardviews = subCardviews else { return }
        guard let dealedCards = dataSource?.dealedCards(subCardviews.count) else { return }
        for (index, dealedCard) in dealedCards.enumerated() {
            subCardviews[index].setImage(cardInfo: dealedCard)
        }
        // 마지막 카드만 뒤집는다.
        subCardviews.last?.turnOver(true)
    }

}
