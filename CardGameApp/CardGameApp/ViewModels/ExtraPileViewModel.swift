//
//  ExtraPileViewModel.swift
//  CardGameApp
//
//  Created by yuaming on 17/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

class ExtraPileViewModel {
  private var extraPile: CardStack
  
  init(_ extraPile: CardStack) {
    self.extraPile = extraPile
  }

  func setUp(completion: @escaping (CardViewModel) -> Void) {
    extraPile.forEach {
      completion(CardViewModel(card: $0).generate())
    }
  }
  
  @discardableResult func choice() -> Card? {
    guard let card = extraPile.choice() else { return nil }
    NotificationCenter.default.post(name: .cardDidChoiceInExtraPile,
                                    object: nil,
                                    userInfo: ["card": card, "remainingQuantity": extraPile.count])
    return card
  }
}

extension Notification.Name {
  static let cardDidChoiceInExtraPile = Notification.Name(rawValue: "CardDidChoiceInExtraPile")
}
