//
//  CardView.swift
//  CardGameApp
//
//  Created by yuaming on 03/04/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class CardView: UIImageView {
  private var card: Card?
  override var frame: CGRect {
    didSet {
      self.layer.cornerRadius = 3
      self.layer.masksToBounds = true
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setCardImage()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  convenience init(frame: CGRect, card: Card) {
    self.init(frame: frame)
    self.card = card
  }
}

private extension CardView {
  func setCardImage() {
    if let card = self.card {
      self.image = card.bringFrontImage()
    } else {
      self.image =  UIImage(imageLiteralResourceName: LiteralResoureNames.cardBack)
    }
  }
}
