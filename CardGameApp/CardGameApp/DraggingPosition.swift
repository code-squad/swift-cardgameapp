//
//  dragPosition.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 3. 25..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

enum DraggingPosition {
    case columns(column: Int, row: Int)
    case goals(column: Int)
    case preview
}
