//
//  Constants.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 6..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

struct Constants {
    struct GameBoard {
        static let maxStud: Int = 7
        static let horizontalStackSpacing: CGFloat = 4
        static let vacantSpaceCount: Int = 4
    }

    struct CardView {
        static let cornerRadius: CGFloat = 5
        static let clipsToBounds: Bool = true
        static let borderColor: CGColor = UIColor.white.cgColor
        static let borderWidth: CGFloat = 2
    }

    struct ImageName {
        static let refresh: String = "cardgameapp-refresh-app"
        static let background: String = "bg_pattern"
        static let cardBack: String = "card-back"
    }
}
