//
//  PileView.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 3. 15..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

protocol PileView: AnyObject {
    func addPileStackView(count: Int)
    func removePileStackView(count: Int)
}
