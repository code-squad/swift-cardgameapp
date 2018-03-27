//
//  CardStacksView.swift
//  CardGameApp
//
//  Created by 권재욱 on 2018. 3. 27..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import UIKit

class CardStacksView: UIStackView {

    private var cardStackViews = [[UIImageView]]() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawStacks()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        drawStacks()
    }
    
    func setStacks(_ stacksViews: [[UIImageView]]) {
        self.cardStackViews = stacksViews
        spacing = UIStackView.spacingUseDefault
        distribution = .fillEqually
        drawStacks()
    }
    
    private func drawStacks() {
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
