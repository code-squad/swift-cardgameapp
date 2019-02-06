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

    var isEmpty: Bool {
        return cardViewModels.isEmpty
    }

    func push(_ cardViewModel: CardViewModel) {
        cardViewModels.append(cardViewModel)
    }

    func pop() -> CardViewModel? {
        if cardViewModels.isEmpty { return nil }
        return cardViewModels.removeLast()
    }

}
