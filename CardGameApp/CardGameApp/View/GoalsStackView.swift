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
        for view in arrangedSubviews {
            guard view.frame.contains(location),
                let indexOfView = arrangedSubviews.firstIndex(of: view) else { continue }
            return DraggingPosition.goals(column: indexOfView)
        }
        return nil
    }
    
    func draggingView(_ location: CGPoint) -> [CardImageView]? {
        for view in arrangedSubviews {
            guard view.frame.contains(location),
                let stackView = view as? UIStackView,
                let cardImageView = stackView.arrangedSubviews.last as? CardImageView else { continue }
            return [cardImageView]
        }
        return nil
    }
}
