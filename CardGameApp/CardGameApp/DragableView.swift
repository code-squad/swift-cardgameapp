//
//  DragableView.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 3. 25..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

protocol DragableView {
    func draggingPosition(_ location: CGPoint) -> DraggingPosition?
    func draggingView(_ location: CGPoint) -> [CardImageView]?
}
