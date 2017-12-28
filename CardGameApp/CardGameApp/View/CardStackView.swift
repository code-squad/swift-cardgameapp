//
//  CardStackView.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 28..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

class CardStackView: UIView {
    var stackView: UIStackView?
    var cardStack: CardStack? {
        willSet(newValue) {
            makeCardStackView(newValue)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    deinit {
        stackView = nil
        cardStack = nil
    }
}

// Settings
extension CardStackView {
    func setCards(_ cardStack: CardStack) {
        self.cardStack = cardStack
    }

    private func makeCardStackView(_ cardStack: CardStack?) {
        guard var cardStack = cardStack else { return }
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        while cardStack.count > 1 {
            guard let card = cardStack.pop() else { break }
            let backCardView = makeBackCardImageView(card)
            myStackView.addArrangedSubview(backCardView)
        }
        guard let lastCard = cardStack.pop() else { return}
        let lastCardView = makeLastCardImageView(lastCard)
        myStackView.addArrangedSubview(lastCardView)
        self.stackView = myStackView
    }

    private func makeBackCardImageView(_ card: Card) -> UIImageView {
        let backCardImage = card.makeBackImage()
        let cardView = UIImageView(image: backCardImage)
        cardView.height(constant: 20)
        cardView.contentMode = .top
        return cardView
    }

    private func makeLastCardImageView(_ card: Card) -> UIImageView {
        let lastCardImage = card.makeImage()
        let lastCardView = UIImageView(image: lastCardImage)
        return lastCardView
    }
}
