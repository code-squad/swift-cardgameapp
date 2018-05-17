//
//  CardView.swift
//  CardGameApp
//
//  Created by yuaming on 03/04/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class CardView: UIImageView {
  private var viewModel: CardViewModel!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  convenience init(frame: CGRect, viewModel: CardViewModel) {
    self.init(frame: frame)
    self.viewModel = viewModel
    initialize()
  }
}

private extension CardView {
  func initialize() {
    self.layer.cornerRadius = 3
    self.layer.masksToBounds = true
    self.image = UIImage(imageLiteralResourceName: viewModel.getCardImageName())
  }
}
