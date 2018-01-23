//
//  Size.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 17..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

struct Size {
    static let constant: CGFloat = 3
    static let cardStackCount: Int = 7
    static var cardWidth: CGFloat = 0
    static var cardHeight: CGFloat = 0
    static let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
}

struct Position {
    var stackIndex: Int
    var cardIndex: Int
}

struct Image {
    static let refreshImage = UIImage(named: "cardgameapp-refresh-app")!
    static let backImage = UIImage(named: "card-back")!
    static let bgImage = UIImage(named: "bg_pattern")!
}
