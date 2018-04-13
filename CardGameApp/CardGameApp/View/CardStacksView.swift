//
//  CardStacksView.swift
//  CardGameApp
//
//  Created by 권재욱 on 2018. 3. 27..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import UIKit

class CardStacksView: UIStackView {
    
    enum Status {
        case none
        case began
        case moved
        case ended
    }

    private var cardStackViews = [[UIImageView]]() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setStacks(_ stacksViews: [[UIImageView]]) {
        self.cardStackViews = stacksViews
        spacing = UIStackView.spacingUseDefault
        distribution = .fillEqually
    }
    
    func drawStacks() {
        self.subviews.forEach { $0.removeFromSuperview() }
        for oneStack in cardStackViews {
            drawOneStack(oneStack)
        }
    }
    
    private func drawOneStack(_ oneStack: [UIImageView]) {
        for oneCardImg in oneStack {
                oneCardImg.contentMode = .scaleAspectFill
                oneCardImg.clipsToBounds = true
                oneCardImg.layer.cornerRadius = 5
                addSubview(oneCardImg)
        }
    }
    
}
