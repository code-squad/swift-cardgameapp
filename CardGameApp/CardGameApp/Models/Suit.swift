//
//  Suit.swift
//  CardGameApp
//
//  Created by yuaming on 08/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

enum Suit {
  case heart, diamond, club, spade
  
  static var allValues: [Suit] {
    return [.club, .diamond, .heart, .spade]
  }
}

extension Suit: Comparable {
  static func <(lhs: Suit, rhs: Suit) -> Bool {
    switch (lhs, rhs) {
    case (_, _) where lhs == rhs:
      return false
    case (.spade, _),
         (.heart, .diamond), (.heart, .club),
         (.diamond, .club):
      return false
    default:
      return true
    }
  }
}

extension Suit: CustomStringConvertible {
  var description: String {
    switch self {
    case .heart:
      return "h"
    case .diamond:
      return "d"
    case .club:
      return "c"
    case .spade:
      return "s"
    }
  }
}
