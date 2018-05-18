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
  
  func addCardViewModels() {
    guard isAvailable else { return }
    
    for pileIndex in 0...tableauPiles.count-1 {
      var cardIndex = 0
      
      tableauPiles[pileIndex].forEach {
        addCardViewModel(pileIndex, cardIndex, card: $0, status: .front)
        cardIndex += 1
      }
    }
  }
  
  func addCardViewModel(_ pileIndex: Int, _ cardIndex: Int, card: Card, status: CardViewModel.Status = .back) {
    delegate?.setCardViewModel(pileIndex, cardIndex, with: CardViewModel(card: card, status: status))
  }

  
  var isAvailable: Bool {
    return tableauPiles.count > 0
  }
}
