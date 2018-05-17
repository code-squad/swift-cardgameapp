//
//  Number.swift
//  CardGameApp
//
//  Created by yuaming on 08/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

enum Number: Int {
  case ace = 1, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king 
  
  static var allValues: [Number] {
    return [.ace, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .jack, .queen, .king]
  }
}

extension Number {
  var straightValues: [Int] {
    return [self.rawValue] + (self == .ace ? [0] : [])
  }
}

extension Number {
  static func != (lhs: Number, rhs: Number) -> Bool {
    return lhs.rawValue != rhs.rawValue
  }
}

extension Number: CustomStringConvertible {
  var description: String {
    switch self {
    case .ace:
      return "A"
    case .king:
      return "K"
    case .queen:
      return "Q"
    case .jack:
      return "J"
    default:
      return String(self.rawValue)
    }
  }
}
