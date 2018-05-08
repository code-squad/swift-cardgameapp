//
//  EmptyView.swift
//  CardGameApp
//
//  Created by yuaming on 08/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class EmptyView: UIImageView {
  private var hasBorder: Bool = false
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layoutWithInitializer()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  convenience init(frame: CGRect, hasBorder: Bool) {
    self.init(frame: frame)
    self.hasBorder = hasBorder
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

private extension EmptyView {
  func layoutWithInitializer() {
    guard hasBorder else { return }
    
    self.layer.borderColor = UIColor.white.cgColor
    self.layer.borderWidth = 2
    self.layer.cornerRadius = 3
    self.layer.masksToBounds = true
  }
}
