//
//  CardStackViewModel.swift
//  CardGameApp
//
//  Created by 윤지영 on 29/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import Foundation

protocol CardStackViewModelDelegate {
    init(cardStack: CardStack)
    var imageNames: [String?]? { get }
    var imagesDidChange: ((CardStackViewModelDelegate) -> ())? { get set }
    func flipLast()
}

class CardStackViewModel: CardStackViewModelDelegate {
    private let cardStack: CardStack
    private var cardViewModels: [CardViewModel]

    required init(cardStack: CardStack) {
        self.cardStack = cardStack
        self.cardViewModels = []
        for card in cardStack {
            let cardViewModel = CardViewModel(card: card)
            cardViewModels.append(cardViewModel)
        }
    }

    var imageNames: [String?]? {
        didSet {
            imagesDidChange?(self)
        }
    }

    var imagesDidChange: ((CardStackViewModelDelegate) -> ())?

    func flipLast() {
        guard let lastCard = cardViewModels.last else { return }
        lastCard.flip()
    }

}
