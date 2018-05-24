//
//  TableauPilesViewModel.swift
//  CardGameApp
//
//  Created by yuaming on 18/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

class TableauPilesViewModel {
  private var tableauPiles: TableauPiles
  
  init(_ tableauPiles: TableauPiles) {
    self.tableauPiles = tableauPiles
  }
  
  func setUp(completion: @escaping (CardViewModel, Int, Int) -> Void) {
    for (pileIndex, pile) in tableauPiles.enumerated() {
      for (cardIndex, card) in pile.enumerated() {
        let isEnded = pileIndex == cardIndex
        completion(CardViewModel(card: card, isTurnedOver: isEnded).generate(), pileIndex, cardIndex)
      }
    }
  }
}
