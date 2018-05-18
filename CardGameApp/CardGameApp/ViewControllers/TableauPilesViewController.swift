//
//  TableauPilesViewController.swift
//  CardGameApp
//
//  Created by yuaming on 18/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class TableauPilesViewController: UIViewController {
  var tableauPilesViewModel: TableauPilesViewModel! {
    didSet {
      self.tableauPilesViewModel.delegate = self
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
    configueTablePileView()
  }
  
  func configueTablePileView() {
    tableauPilesViewModel.addCardViewModels()
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
extension TableauPilesViewController: TableauPilesViewContrllerDelegate {
  func setCardViewModel(_ pileIndex: Int, _ cardIndex: Int, with cardViewModel: CardViewModel) {
    let tableauPileViewController = TableauPileViewController()
    tableauPileViewController.addView(pileIndex: pileIndex, cardIndex: cardIndex, with: cardViewModel)
    ViewUtility.addChildViewController(child: tableauPileViewController, to: self)
  }
}
