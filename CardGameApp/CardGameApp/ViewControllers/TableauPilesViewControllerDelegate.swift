//
//  TableauPilesViewControllerDelegate.swift
//  CardGameApp
//
//  Created by yuaming on 18/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

protocol TableauPilesViewContrllerDelegate {
  func setCardViewModel(_ pileIndex: Int, _ cardIndex: Int, with cardViewModel: CardViewModel)
}
