//
//  BlankSpaceView.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 1. 29..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

@IBDesignable
class BlankSpaceView: UIView {

    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
    }


}
