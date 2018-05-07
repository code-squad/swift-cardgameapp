//
//  CardView.swift
//  CardGameApp
//
//  Created by yuaming on 03/04/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class CardView: UIImageView {
  override func layoutSubviews() {
    super.layoutSubviews()
    loadDefaultOptions()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    loadDefaultOptions()
    self.frame = frame
  }
}

// MARK: - Private funcions
private extension CardView {
  func loadDefaultOptions() {
    self.layer.cornerRadius = 3
    self.layer.masksToBounds = true
    self.image = UIImage(imageLiteralResourceName:"CardBack")
  }
}
