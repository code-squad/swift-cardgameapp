//
//  GoalView.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 27..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class GoalView: CardImageView {
    
    override func postInfo() {
        NotificationCenter.default.post(name: .doubleTapGoalView,
                                        object: self)
    }
}
