//
//  FoundationView.swift
//  CardGameApp
//
//  Created by 권재욱 on 2018. 3. 26..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import UIKit

class FoundationView: UIStackView {
    
    private var CardImgViews = [UIImageView]() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawFoundation()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        drawFoundation()
    }
    
    func setFoundation(_ imgView: [UIImageView]) {
        self.CardImgViews = imgView
        spacing = UIStackView.spacingUseDefault
        distribution = .fillEqually
        drawFoundation()
    }
    
    private func drawFoundation() {
        for oneFoundation in CardImgViews {
            oneFoundation.contentMode = .scaleAspectFill
            oneFoundation.clipsToBounds = true
            oneFoundation.layer.cornerRadius = 5
            oneFoundation.layer.borderColor = UIColor.white.cgColor
            oneFoundation.layer.borderWidth = 1
            addSubview(oneFoundation)
        }
    }
    
}
