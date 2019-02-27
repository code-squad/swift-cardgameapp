//
//  Preview.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 21..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class Preview: CardStack {
    
    override func postInfo() {
        NotificationCenter.default.post(name: .previewDidChange,
                                        object: self,
                                        userInfo: self.userInfo())
    }
}
