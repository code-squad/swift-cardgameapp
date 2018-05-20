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
  private var card: Card
  private var isTurnedOver: Bool
  
  init(card: Card, isTurnedOver: Bool = false) {
    self.card = card
    self.isTurnedOver = isTurnedOver
  }
}

extension CardViewModel {
  func getCardImage() -> UIImage {
    guard isTurnedOver else { return Image.cardBack }
    
    return UIImage(imageLiteralResourceName: card.bringFrontImageName())
  }
}

