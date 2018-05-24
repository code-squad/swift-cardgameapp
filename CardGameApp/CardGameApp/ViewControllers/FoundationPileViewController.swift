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
    guard let cardViewModel = cardViewModel else {
      self.view.addEmptyView(widthPosition: pileIndex)
      return
    }

    self.view.addCardView(with: cardViewModel)
  }
}
