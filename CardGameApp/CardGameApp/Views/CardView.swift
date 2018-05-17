//
//  CardView.swift
//  CardGameApp
//
//  Created by yuaming on 03/04/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class CardView: UIImageView {
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  convenience init(viewModel: CardViewModel) {
    self.init(frame: .zero)
    self.frame = setFrame()
    initialize(viewModel)
  }
}

private extension CardView {
  func initialize(_ viewModel: CardViewModel) {
    self.layer.cornerRadius = 3
    self.layer.masksToBounds = true
    self.image = viewModel.getCardImage()
  }
}
