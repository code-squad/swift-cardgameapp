//
//  CardView.swift
//  CardGameApp
//
//  Created by yuaming on 03/04/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class CardView: UIImageView {
  override var frame: CGRect {
    didSet {
      self.layer.cornerRadius = 3
      self.layer.masksToBounds = true
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  convenience init(frame: CGRect, image: UIImage) {
    self.init(frame: frame)
    self.image = image
  }
}
