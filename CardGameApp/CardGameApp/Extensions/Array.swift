//
//  Array+.swift
//  CardGameApp
//
//  Created by yuaming on 08/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

extension Array {
  func shuffle() -> Array {
    var array = self
    guard count > 1 else { return array }
    
    for i in 0..<(count-1) {
      let j = Int(arc4random_uniform(UInt32(count-i))) + i
      guard i != j else { continue }
      
      array.swapAt(i, j)
    }
    
    return array
  }
}
