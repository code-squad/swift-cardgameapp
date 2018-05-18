//
//  FoundationPileViewController.swift
//  CardGameApp
//
//  Created by yuaming on 18/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class FoundationPileViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func addView(pileIndex: Int, with cardViewModel: CardViewModel?) {
    fitFrame(pileIndex)
    
    guard let cardViewModel = cardViewModel else {
      addEmptyView()
      return
    }

    addCardView(cardViewModel)
  }
}

private extension FoundationPileViewController {
  func addEmptyView() {
    let emptyView = UIImageView()
    emptyView.generateEmptyView()
    view.addSubview(emptyView)
  }
  
  func addCardView(_ viewModel: CardViewModel) {
    let cardView = CardView(viewModel: viewModel)
    view.addSubview(cardView)
  }
  
  func fitFrame(_ widthPosition: Int) {
    view.frame = view.setFrame(widthPosition: widthPosition) 
  }
}
