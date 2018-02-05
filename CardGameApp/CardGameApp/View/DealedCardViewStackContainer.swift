//
//  DealedCardStackViewContainer.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 4..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class DealedCardViewStackContainer: UIStackView {
    private var subStacks: [DealedCardViewStack]? {
        return self.arrangedSubviews as? [DealedCardViewStack]
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(frame: CGRect, dealedCardViewStacks: [DealedCardViewStack], spacing: CGFloat) {
        self.init(frame: frame)
        setupStacks(innerStacks: dealedCardViewStacks)
        let stackViewInfo = StackViewInfo(axis: .horizontal,
                                          distribution: .fillEqually,
                                          spacing: spacing,
                                          bottomMargin: 0)
        stackSettings(stackViewInfo)
    }

}
