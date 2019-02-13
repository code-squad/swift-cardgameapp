//
//  ColumnStackView.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 14..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class ColumnStackView: UIStackView {

    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.spacing = self.frame.width * 1.27 / 3
    }
}
