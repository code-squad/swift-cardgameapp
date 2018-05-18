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
    ViewUtility.fitFrame(view: self.view, widthPosition: pileIndex)
    
    guard let cardViewModel = cardViewModel else {
      ViewUtility.addEmptyView(view: self.view)
      return
    }

    ViewUtility.addCardView(view: self.view, with: cardViewModel)
  }
}
