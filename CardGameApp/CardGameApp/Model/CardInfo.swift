//
//  CardInfo.swift
//  CardGameApp
//
//  Created by 권재욱 on 2018. 4. 3..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import Foundation

struct CardInfo {
    
    let indexOfCard: Int
    let stackIndex: Int
    let position: ImgFrameMaker.Position
    
    init(_ indexOfCard: Int, _ stackIndex: Int, _ position: ImgFrameMaker.Position) {
        self.indexOfCard = indexOfCard
        self.stackIndex = stackIndex
        self.position = position
    }
    
}
