//
//  StandStackView.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 9..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

@IBDesignable
class StandStackView: UIStackView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let subViewHeight = self.arrangedSubviews.last?.frame.height else { return }
        self.spacing = -subViewHeight
    }
}
