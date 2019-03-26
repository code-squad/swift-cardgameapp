//
//  PreviewStackView.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 3. 24..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class PreviewStackView: PositionStackView, DragableView {
    func draggingPosition(_ location: CGPoint) -> DraggingPosition? {
        return DraggingPosition.preview
    }
    
    func draggingView(_ location: CGPoint) -> [CardImageView]? {
        return []
    }
}
