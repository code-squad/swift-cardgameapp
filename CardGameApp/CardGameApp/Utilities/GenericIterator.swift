//
//  GenericIterator.swift
//  CardGameApp
//
//  Created by yuaming on 20/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

class GenericIterator<Element>: IteratorProtocol {
  private let elements: [Element]
  private var nextIndex = 0
    
  init(_ elements: [Element]) {
    self.elements = elements
  }
    
  func next() -> Element? {
    nextIndex += 1
    guard nextIndex < elements.count else { return nil }
    return elements[nextIndex]
  }
}
