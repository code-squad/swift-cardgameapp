//
//  GameViewControllerDelegate.swift
//  CardGameApp
//
//  Created by yuaming on 18/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

protocol GameViewControllerDelegate {
  func updateCardViewModelInExtraPile(_ cardViewModel: CardViewModel)
  func updateCardViewModelInWastePile(_ cardViewModel: CardViewModel)
  func updateEmptyViewInExtraPile()
  func updateEmptyViewInWastePile()
  func updateRefreshViewInExtraPile()
}
