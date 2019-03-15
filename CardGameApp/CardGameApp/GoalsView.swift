//
//  GoalsView.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 3. 15..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

protocol GoalsView: AnyObject {
    func addGoalsStackView(cards: [Card], index: Int)
    func removeGoalsStackView(count: Int, index: Int)
}
