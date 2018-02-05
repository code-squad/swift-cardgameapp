//
//  VacantCardStackView.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 4..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class VacantCardViewStack: CardViewStack {
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(frame: CGRect, sizeOf spaceSize: CGSize, spaceCount count: Int, spacing: CGFloat) {
        self.init(frame: frame)
        for _ in 0..<count {
            let vacantCardView = CardView(sizeOf: spaceSize)
            self.addArrangedSubview(vacantCardView)
        }
        let stackInfo = StackViewInfo(axis: .horizontal,
                                      distribution: .fillEqually,
                                      spacing: spacing,
                                      bottomMargin: 0)
        stackSettings(stackInfo)
    }

}
