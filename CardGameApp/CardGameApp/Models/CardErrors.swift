//
//  CardErrors.swift
//  CardGameApp
//
//  Created by yuaming on 08/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

enum CardErrors: Error {
  case notEnoughCards
  case emptyValue
  
  var localizedDescription: String {
    switch self {
    case .notEnoughCards:
      return "카드 수가 충분하지 않습니다."
    case .emptyValue:
      return "입력 값이 없습니다."
    }
  }
}
