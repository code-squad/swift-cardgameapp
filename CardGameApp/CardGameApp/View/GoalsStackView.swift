//
//  GoalsStackView.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 3. 24..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class GoalsStackView: UIStackView, DragableView {
    func draggingPosition(_ location: CGPoint) -> DraggingPosition? {
        return nil
    }
    
    func draggingView(_ location: CGPoint) -> [CardImageView]? {
        return []
    }
}
