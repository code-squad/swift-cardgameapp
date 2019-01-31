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
        
        let name = description
        return isFront ? UIImage(named: name) : UIImage(named: "card_back")
    }
}
