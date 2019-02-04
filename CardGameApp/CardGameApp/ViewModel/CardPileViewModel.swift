//
//  CardPileViewModel.swift
//  CardGameApp
//
//  Created by 윤지영 on 04/02/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import Foundation

class CardPileViewModel {
    private var cardViewModels: [CardViewModel]
    
    init() {
        self.cardViewModels = []
    }

    func pileUp(cardViewModel: CardViewModel) {
        cardViewModels.append(cardViewModel)
    }

    func removeAll() -> [CardViewModel] {
        defer {
            cardViewModels.removeAll()
        }
        return cardViewModels
    }

}
