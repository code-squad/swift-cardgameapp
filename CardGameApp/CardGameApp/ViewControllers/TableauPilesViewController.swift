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
      self.tableauPilesViewModel.delegate = self
      initialize()
    }
  }
  
  private var tableauPileViewController: TableauPileViewController = TableauPileViewController()
  private var isEnded: Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

private extension TableauPilesViewController {
  func initialize() {
    removeAllViewControllers()
    configueTablePileView()
  }
  
  func removeAllViewControllers() {
    if childViewControllers.count > 0 {
      for child in childViewControllers {
        self.removeChildViewController(child: child)
      }
    }
  }
  
  func configueTablePileView() {
    tableauPilesViewModel.updateCardViewModels()
  }
}

// MARK:- TableauPilesViewContrllerDelegate
extension TableauPilesViewController: TableauPilesViewContrllerDelegate {
  func updateCardViewModel(_ pileIndex: Int, _ cardIndex: Int, with cardViewModel: CardViewModel) {
    tableauPileViewController.addView(pileIndex: pileIndex, cardIndex: cardIndex, with: cardViewModel)
    self.addChildViewController(child: tableauPileViewController)
    
    if isEnded {
      tableauPileViewController = TableauPileViewController()
    }
  }
  
  func updateLastPositionFlag(_ isEnded: Bool) {
    self.isEnded = isEnded
  }
}
