//
//  CardStackView.swift
//  CardGameApp
//
//  Created by 윤지영 on 28/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

class CardStackView: UIView {
    private var cardViews: [CardView]

    required init?(coder aDecoder: NSCoder) {
        cardViews = []
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        cardViews = []
        super.init(frame: frame)
    }

    convenience init() {
        self.init(frame: CGRect())
    }

    func addCardView(_ cardView: CardView) {
        cardViews.append(cardView)
        addSubview(cardView)
    }

    func setImages(named names: [String?]) {
        for (index, name) in names.enumerated() {
            guard index < cardViews.count else { return }
            cardViews[index].setImage(named: name)
        }
    }

}
