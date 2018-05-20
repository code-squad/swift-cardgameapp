//
//  TableauPilesViewModel.swift
//  CardGameApp
//
//  Created by yuaming on 18/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

class TableauPilesViewModel {
  var delegate: TableauPilesViewContrllerDelegate?
  private var tableauPiles: TableauPiles
  
  init(_ tableauPiles: TableauPiles) {
    self.tableauPiles = tableauPiles
  }
  
  func updateCardViewModels() {
    guard tableauPiles.isAvailable else { return }
    
    for (pileIndex, pile) in tableauPiles.enumerated() {
      for (cardIndex, card) in pile.enumerated() {
        let isEnded = pileIndex == cardIndex
        
        updateLastPositionFlag(isEnded)
        updateCardViewModel(pileIndex, cardIndex, card: card, isTurnedOver: isEnded)
      }
    }
  }
  
  func updateCardViewModel(_ pileIndex: Int, _ cardIndex: Int, card: Card, isTurnedOver: Bool = false) {
    delegate?.updateCardViewModel(pileIndex, cardIndex, with: CardViewModel(card: card, isTurnedOver: isTurnedOver))
  }
  
  func updateLastPositionFlag(_ isEnded: Bool) {
    delegate?.updateLastPositionFlag(isEnded)
  }
}
