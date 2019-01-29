//
//  CardStacksView.swift
//  CardGameApp
//
//  Created by 윤지영 on 29/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

class CardStacksView: UIView {
    private var cardStackViews: [CardStackView]

    required init?(coder aDecoder: NSCoder) {
        cardStackViews = []
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        cardStackViews = []
        super.init(frame: frame)
    }

    convenience init() {
        self.init(frame: CGRect())
    }

    func addCardStackView(_ cardStackView: CardStackView) {
        cardStackViews.append(cardStackView)
        addSubview(cardStackView)
    }

    func setImages(named imageNamesArray: [[String?]]) {
        for (index, imageNames) in imageNamesArray.enumerated() {
            guard index < cardStackViews.count else { return }
            cardStackViews[index].setImages(named: imageNames)
        }
    }

}
