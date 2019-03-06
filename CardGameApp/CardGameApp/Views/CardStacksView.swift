//
//  CardStacksView.swift
//  CardGameApp
//
//  Created by 윤동민 on 20/02/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

class CardStacksView: UIStackView {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetting()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetting()
    }
    
    convenience init(frame: CGRect, _ cardStacks: [CardStack]) {
        self.init(frame: frame)
        initialCardStacks(cardStacks)
    }

    private func initialSetting() {
        self.spacing = 5
        self.axis = .horizontal
        self.distribution = .fillEqually
    }
    
    private func initialCardStacks(_ cardStacks: [CardStack]) {
        var stackView: CardStackView
        for cardStack in cardStacks {
            stackView = CardStackView(frame: CGRect(x: 0, y: 0, width: Sizes.cardWitdh, height: 500),  cardStack)
            stackView.backgroundColor = UIColor.clear
            addArrangedSubview(stackView)
        }
    }
    
    func removeCardView(at stackNumber: Int) {
        guard let stackView = self.arrangedSubviews[stackNumber] as? CardStackView else { return }
        stackView.removeFromStack()
    }
    
    func turnLastCard(at stackNumber: Int, stackModel: CardStack) {
        guard let stackView = self.arrangedSubviews[stackNumber] as? CardStackView else { return }
        stackView.turnLastCard(stackModel)
    }
}
