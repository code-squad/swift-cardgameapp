//
//  CardImageViewDataSource.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 1. 31..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

protocol CardImageViewDataSource: AnyObject {
    
    func image() -> UIImage?
}

extension Card: CardImageViewDataSource {
    
    func image() -> UIImage? {
        
        if isFront {
            let name = description
            return UIImage(named: name)
        } else {
            return UIImage(named: "card_back")
        }
    }
}
