//
//  ViewSettings.swift
//  CardGameApp
//
//  Created by yuaming on 17/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

struct ViewSettings {
  static let cardCount: Int = 7
  static let foundationCount: Int = 4
  static let spacing: CGFloat = 3
  static var cardWidth: CGFloat = 0
  static var cardHeight: CGFloat = 0
}

struct Image {
  static let cardBack = UIImage(imageLiteralResourceName: LiteralResoureNames.cardBack)
  static let refresh = UIImage(imageLiteralResourceName: LiteralResoureNames.refresh)
  static let gameBack = UIImage(imageLiteralResourceName: LiteralResoureNames.board)
}
