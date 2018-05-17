//
//  Card.swift
//  CardGameApp
//
//  Created by yuaming on 08/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

struct Card {
  private(set) var suit: Suit
  private(set) var number: Number
  
  init(_ suit: Suit, _ number: Number) {
    self.suit = suit
    self.number = number
  }
}

extension Card {
  func bringFrontImageName() -> String {
    return self.description
  }
}

extension Card: Equatable, Comparable {
  static func ==(lhs: Card, rhs: Card) -> Bool {
    return lhs.suit == rhs.suit && lhs.number == rhs.number
  }
  
  static func <(lhs: Card, rhs: Card) -> Bool {
    return lhs.number == rhs.number ? lhs.suit < rhs.suit : UInt8(lhs.number.rawValue) < UInt8(rhs.number.rawValue)
  }
}

extension Card: CustomStringConvertible {
  var description: String {
    return "\(suit.description)\(number.description)"
  }
}
