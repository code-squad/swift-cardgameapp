//
//  CardStackView.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 28..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

class CardStackView: UIStackView {
    var cardStack: CardStack? {
        willSet(newValue) {
            makeCardStackView(newValue)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    deinit {
        cardStack = nil
    }
}

// Settings
extension CardStackView {
    func setCardStack(_ cardStack: CardStack) {
        self.cardStack = cardStack
    }

    private func makeCardStackView(_ cardStack: CardStack?) {
        guard var cardStack = cardStack else { return }
        self.setAutolayout()
        self.axis = .vertical
        while cardStack.count > 1 {
            guard let card = cardStack.pop() else { break }
            let backCardView = makeImageView(card.makeBackImage())
            self.addArrangedSubview(backCardView)
        }
        guard let lastCard = cardStack.pop() else { return }
        let lastCardView = makeImageView(lastCard.makeImage())
        self.addArrangedSubview(lastCardView)
        self.distribution = .fillEqually
    }

    private func makeImageView(_ image: UIImage) -> UIImageView {
        let cardView = UIImageView(image: image)
        cardView.contentMode = .scaleAspectFill
        return cardView
    }

}
