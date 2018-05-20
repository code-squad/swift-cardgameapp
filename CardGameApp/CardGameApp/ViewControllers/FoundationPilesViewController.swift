//
//  FoundationPilesViewController.swift
//  CardGameApp
//
//  Created by yuaming on 17/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class FoundationPilesViewController: UIViewController {
  var foundationPilesViewModel: FoundationPilesViewModel! {
    didSet {
      self.foundationPilesViewModel.delegate = self
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
    configueFoundationPilesView()
  }
  
  func configueFoundationPilesView() {
    foundationPilesViewModel.addCardViewModels()
  }
  
  func removeAllViewControllers() {
    if childViewControllers.count > 0 {
      for child in childViewControllers {
        ViewUtility.removeChildViewController(child: child)
      }
    }
  }
}

// MARK:- FoundationPilesViewControllerDelegate
extension FoundationPilesViewController: FoundationPilesViewControllerDelegate {
  func updateEmptyView(_ pileIndex: Int) {
    let foundationPileViewController = FoundationPileViewController()
    foundationPileViewController.addView(pileIndex: pileIndex, with: nil)
    ViewUtility.addChildViewController(child: foundationPileViewController, to: self)
  }
}

