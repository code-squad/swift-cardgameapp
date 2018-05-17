//
//  GameViewControllerProtocol.swift
//  CardGameApp
//
//  Created by yuaming on 17/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

protocol GameViewControllerProtocol {
  func setCardViewModelInExtraPile(_ cardViewModel: CardViewModel)
  func setCardViewModelInWastePile(_ cardViewModel: CardViewModel)
  func setEmptyViewInExtraPile()
  func setEmptyViewInWastePile()
  func setRefreshViewInExtraPile()
}
