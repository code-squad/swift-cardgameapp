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
      addEmptyView()
      return
    }
    
    addCardView(cardViewModel)
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

private extension ExtraPileView {
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
