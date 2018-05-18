//
//  TableauPileViewController.swift
//  CardGameApp
//
//  Created by yuaming on 18/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class TableauPileViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func addView(pileIndex: Int, cardIndex: Int, with cardViewModel: CardViewModel?) {
    fitFrame(widthPosition: pileIndex, heightPosition: cardIndex)
    
    guard let cardViewModel = cardViewModel else {
      addEmptyView()
      return
    }
    
    addCardView(cardViewModel)
  }
}

private extension TableauPileViewController {
  func addEmptyView() {
    let emptyView = UIImageView()
    emptyView.generateEmptyView()
    view.addSubview(emptyView)
  }
  
  func addCardView(_ viewModel: CardViewModel) {
    let cardView = CardView(viewModel: viewModel)
    view.addSubview(cardView)
  }
  
  func fitFrame(widthPosition: Int, heightPosition: Int) {
    view.frame = view.setFrame(widthPosition: widthPosition, heightPosition: heightPosition)
  }
}

