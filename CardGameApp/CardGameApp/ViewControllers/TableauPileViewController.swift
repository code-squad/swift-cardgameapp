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
    guard let cardViewModel = cardViewModel else {
      UIView.addEmptyView(in: view, widthPosition: pileIndex)
      return
    }
    
    UIView.addCardView(in: view, with: cardViewModel, widthPosition: pileIndex, heightPosition: cardIndex)
  }
}
