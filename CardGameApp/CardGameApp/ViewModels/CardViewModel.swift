//
//  CardViewModel.swift
//  CardGameApp
//
//  Created by yuaming on 11/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation
import UIKit

class CardViewModel {
  private var card: Card?
  private var status: Status
  
  init(card: Card?, status: Status = .back) {
    self.card = card
    self.status = status
  }
  
  convenience init() {
    self.init(card: nil)
  }
}

extension CardViewModel {
  func getCardImageName() -> String {
    guard let card = self.card else { return "" }
    guard self.status == .front else {
      return LiteralResoureNames.cardBack
    }
    
    return card.bringFrontImageName()
  }
  
  enum Status {
    case front, back
  }
}

