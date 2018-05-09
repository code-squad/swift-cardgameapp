//
//  CardViewModel.swift
//  CardGameApp
//
//  Created by yuaming on 09/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation
import UIKit

class CardViewModel {
  private var frame: CGRect
  private var card: Card?
  
  init(frame: CGRect, card: Card?) {
    self.frame = frame
    self.card = card
  }
  
  convenience init(frame: CGRect) {
    self.init(frame: frame, card: nil)
  }
}

extension CardViewModel {
  func generateView() -> CardView {
    return CardView(frame: frame, image: getCardImage())
  }
}

private extension CardViewModel {
  func getCardImage() -> UIImage {
    if let card = self.card {
      return card.bringFrontImage()
    } else {
      return UIImage(imageLiteralResourceName: LiteralResoureNames.cardBack)
    }
  }
}
