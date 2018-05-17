//
//  WastePileView.swift
//  CardGameApp
//
//  Created by yuaming on 17/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class WastePileView: UIView {
  func addView(_ cardViewModel: CardViewModel?) {
    guard let cardViewModel = cardViewModel else {
      addEmptyView()
      return
    }
    
    addCardView(cardViewModel)
  }
  
  func removeAllViews() {
    subviews.forEach { $0.removeFromSuperview() }
  }
}

private extension WastePileView {
  func addEmptyView() {
    let emptyView = UIImageView()
    emptyView.generateEmptyView()
    addSubview(emptyView)
  }
  
  func addCardView(_ viewModel: CardViewModel) {
    let cardView = CardView(viewModel: viewModel)
    addSubview(cardView)
  }
}
