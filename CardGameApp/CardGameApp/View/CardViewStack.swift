//
//  CardViewStack.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 2..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class CardViewStack: UIStackView {
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(_ cardViews: [CardView], _ frame: CGRect) {
        self.init(frame: frame)
        cardViews.forEach { (cardView) in
            self.addArrangedSubview(cardView)
        }
    }

    func setBottomLayoutMargins(_ bottomMargin: CGFloat) {
        // 이 설정을 해줘야 layoutMargins가 적용된다.
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = UIEdgeInsets(top: 0,
                                          left: 0,
                                          bottom: bottomMargin,
                                          right: 0)
    }

    var lastCard: CardView? {
        return self.arrangedSubviews.last as? CardView
    }

}
