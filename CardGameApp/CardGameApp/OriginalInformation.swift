//
//  OriginalInformation.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 3. 19..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class OriginalInformation {
    // views
    let cardView: CardView
    let cardStackView: CardStackView
    let parentView: UIStackView
    let mainView: UIView
    // dragged cards information
    private(set) var cardInformation: CardInformation?
    private(set) var cardPackForDragging: [CardView]
    private(set) var originParentModel: Sendable?

    init?(cardView: CardView) {
        self.cardView = cardView
        guard let cardStackView = cardView.superview as? CardStackView else { return nil }
        guard let parentView = cardStackView.superview as? UIStackView else { return nil }
        guard let mainView = parentView.superview else { return nil }
        self.cardStackView = cardStackView
        self.parentView = parentView
        self.mainView = mainView
        self.cardPackForDragging = []
        self.originParentModel = getOriginParentModel()
        self.cardInformation = getCardInformation()
        setCardPackForDragging()
    }

    private func getOriginParentModel() -> Sendable? {
        if (parentView as? OpenedCardDeckView) != nil {
            return OpenedCardDeckViewModel.sharedInstance()
        } else if (parentView as? SevenPilesView) != nil {
            return SevenPilesViewModel.sharedInstance()
        } else {
            return nil
        }
    }

    private func getCardInformation() -> CardInformation? {
        return originParentModel?.getSelectedCardInformation(image: cardView.storedImage)
    }

    private func setCardPackForDragging() {
        for index in (cardInformation?.indexes.yIndex)!..<cardStackView.subviews.count {
            guard let card = cardStackView.subviews[index] as? CardView else { continue }
            self.cardPackForDragging.append(card)
        }
    }

    func isDoubleTapable() -> Bool {
        return cardView == cardStackView.subviews[cardStackView.subviews.count-1]
    }

    func animationBegan() {
        mainView.bringSubview(toFront: self.parentView)
        parentView.bringSubview(toFront: self.cardStackView)
    }

    func animationCompletion() {
        parentView.insertSubview(cardStackView, at: cardInformation!.indexes.xIndex)
    }
}
