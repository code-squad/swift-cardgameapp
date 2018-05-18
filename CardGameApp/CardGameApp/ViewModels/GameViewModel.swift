//
//  GameManager.swift
//  CardGameApp
//
//  Created by yuaming on 17/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation
import UIKit

class GameViewModel {
  private var cardDeck: CardDeck
  private(set) var extraPile: CardStack
  private(set) var wastePile: CardStack
  private(set) var foundationPiles: FoundationPiles
  private(set) var tableauPiles: TableauPiles
  
  init() {
    self.cardDeck = CardDeck()
    self.extraPile = CardStack()
    self.wastePile = CardStack()
    self.foundationPiles = FoundationPiles()
    self.tableauPiles = TableauPiles()
  }
}

extension GameViewModel {
  func initialize() {
    cardDeck.reset()
    tableauPiles.reset(with: cardDeck)
    extraPile.reset(with: cardDeck)
    wastePile.reset()
    foundationPiles.reset()
  }
}

