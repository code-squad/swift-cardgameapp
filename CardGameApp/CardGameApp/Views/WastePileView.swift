//
//  WastePileView.swift
//  CardGameApp
//
//  Created by yuaming on 17/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class WastePileView: UIView {  
  func removeAllViews() {
    subviews.forEach { $0.removeFromSuperview() }
  }
}
