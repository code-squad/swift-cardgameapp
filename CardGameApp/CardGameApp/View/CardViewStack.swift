//
//  CardViewStack.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 2..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class CardViewStack: UIStackView {
    var dataSource: CardViewStackDataSource?
    var subCardviews: [CardView]? {
        return self.arrangedSubviews as? [CardView]
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(frame: CGRect, cardViews: [CardView]) {
        self.init(frame: frame)
        setupCardViews(cardViews)
    }

    func setupCardViews(_ cardViews: [CardView]) {
        cardViews.forEach { (cardView) in
            self.addArrangedSubview(cardView)
        }
    }

}
