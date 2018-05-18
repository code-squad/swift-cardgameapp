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
    self.addChildController(asChildViewController: tableauPileViewController)
  }
}

// MARK:- ChildViewController Life Cycle
private extension TableauPilesViewController {
  func addChildController(asChildViewController viewController: UIViewController) {
    addChildViewController(viewController)
    view.addSubview(viewController.view)
    viewController.didMove(toParentViewController: self)
  }
}
