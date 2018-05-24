//
//  FoundationPilesViewController.swift
//  CardGameApp
//
//  Created by yuaming on 17/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class FoundationPilesViewController: BaseViewController {
  var foundationPilesViewModel: FoundationPilesViewModel! {
    didSet {
      initialize()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

private extension FoundationPilesViewController {
  func initialize() {
    removeAllViewControllers()
    setUpFoundationPilesView()
  }

  func removeAllViewControllers() {
    childViewControllers.forEach { self.removeChildViewController(child: $0) }
  }
  
  func setUpFoundationPilesView() {
    (0...ViewSettings.foundationCount-1).forEach { pileIndex in
      let foundationPileViewController = FoundationPileViewController()
      foundationPileViewController.addView(pileIndex: pileIndex)
      self.addChildViewController(child: foundationPileViewController)
    }
  }
}

