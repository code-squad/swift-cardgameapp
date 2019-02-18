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
    case goals(type: Suit)
    case columns(position: Int)
}
