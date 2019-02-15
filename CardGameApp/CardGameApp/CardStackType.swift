//
//  CardStackType.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 15..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

enum CardStackType {
    
    case pile
    case preview
    
    enum goals {
        
        case clubs
        case hearts
        case diamonds
        case spades
    }
    
    enum columns {
        
        case one
        case two
        case three
        case four
        case five
        case six
        case seven
    }
}
