//
//  Keyword.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 2. 23..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

enum Keyword {
    case foundationImages

    var value: String {
        switch self {
        case .foundationImages:
            return "foundationImages"
        }
    }
}
