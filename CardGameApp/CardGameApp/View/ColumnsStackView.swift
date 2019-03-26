//
//  ColumnsStackView.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 3. 25..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class ColumnsStackView: UIStackView, DragableView {
    
    func draggingPosition(_ location: CGPoint) -> DraggingPosition? {
        for subStackView in arrangedSubviews {
            guard let stackView = subStackView as? UIStackView,
                stackView.frame.contains(location) else {
                    continue
                    
            }
            for view in stackView.arrangedSubviews.reversed() {
                guard !(view is CardBackImageView) else {
                    continue
                    
                }
                let frame = stackView.convert(view.frame, to: self)
                guard frame.contains(location),
                    let column = arrangedSubviews.firstIndex(of: subStackView),
                    let row = stackView.arrangedSubviews.firstIndex(of: view) else {
                        continue
                        
                }
                return DraggingPosition.columns(column: column, row: row)
            }
        }
        return nil
    }
    
    func draggingView(_ location: CGPoint) -> [CardImageView]? {
        for subStackView in arrangedSubviews {
            guard let stackView = subStackView as? UIStackView,
                stackView.frame.contains(location) else { continue }
            for view in stackView.arrangedSubviews.reversed() {
                guard !(view is CardBackImageView) else { continue }
                let frame = stackView.convert(view.frame, to: self)
                guard frame.contains(location) else { continue }
                return stackView.suffix(of: view) as? [CardImageView]
            }
        }
        return nil
    }
}
