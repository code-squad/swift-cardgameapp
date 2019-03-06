//
//  CardSpacesView.swift
//  CardGameApp
//
//  Created by 윤동민 on 05/03/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

class CardSpacesView: UIStackView {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetting()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetting()
    }

    convenience init(frame: CGRect, _ spacesView: [SpaceView]) {
        self.init(frame: frame)
        for spaceView in spacesView { addArrangedSubview(spaceView) }
    }
    
    private func initialSetting() {
        self.spacing = 5
        self.axis = .horizontal
        self.distribution = .fillEqually
    }
    
    func addCardView(at number: Int, card: Card) {
        guard let spaceView = arrangedSubviews[number] as? SpaceView else { return }
        let cardView = CardView(frame: CGRect(x: Sizes.originX, y: Sizes.originY, width: Sizes.cardWitdh, height: Sizes.cardHeight))
        cardView.setCardImage(name: card.description)
        spaceView.addCardView(cardView)
    }
}
