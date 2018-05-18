//
//  ExtraPileView.swift
//  CardGameApp
//
//  Created by yuaming on 17/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class ExtraPileView: UIView {  
  func addView(_ cardViewModel: CardViewModel?) {
    guard let cardViewModel = cardViewModel else {
      ViewUtility.addEmptyView(view: self)
      return
    }
    
    ViewUtility.addCardView(view: self, with: cardViewModel)
  }
  
  func addRefreshView() {
    let refreshView = UIImageView()
    refreshView.generateRefreshView()
    addSubview(refreshView)
  }
  
  func removeAllViews() {
    subviews.forEach { $0.removeFromSuperview() }
  }
  
  func addTapGesture(_ tapGesture: UITapGestureRecognizer) {
    tapGesture.numberOfTapsRequired = 1
    addGestureRecognizer(tapGesture)
  }
}
