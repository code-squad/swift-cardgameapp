//
//  TableauPilesViewController.swift
//  CardGameApp
//
//  Created by yuaming on 18/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class TableauPilesViewController: BaseViewController {
  var tableauPilesViewModel: TableauPilesViewModel! {
    didSet {
      initialize()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

private extension TableauPilesViewController {
  func initialize() {
    removeAllViewControllers()
    setUpTablePilesView()
  }
  
  func removeAllViewControllers() {
    childViewControllers.forEach { self.removeChildViewController(child: $0) }
  }
  
  func setUpTablePilesView() {
    var tablePileViewController = TableauPileViewController()
    tableauPilesViewModel.takeCardModels() { (cardViewModel, pileIndex, cardIndex) in
      tablePileViewController.addView(pileIndex: pileIndex, cardIndex: cardIndex, with: cardViewModel)
      self.addChildViewController(child: tablePileViewController)
      
      if pileIndex == cardIndex {
        tablePileViewController = TableauPileViewController()
      }
    }
  }
}

