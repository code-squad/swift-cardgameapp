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
    configueTablePileView()
  }
  
  func configueTablePileView() {
    tableauPilesViewModel.addCardViewModels()
  }
}

// MARK:- FoundationPilesViewControllerDelegate
extension TableauPilesViewController: TableauPilesViewContrllerDelegate {
  func setCardViewModel(_ pileIndex: Int, _ cardIndex: Int, with cardViewModel: CardViewModel) {
    let tableauPileViewController = TableauPileViewController()
    tableauPileViewController.addView(pileIndex: pileIndex, cardIndex: cardIndex, with: cardViewModel)
    ViewUility.addChildViewController(child: tableauPileViewController, to: self)
  }
}
