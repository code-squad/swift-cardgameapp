//
//  KlondikeView.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 3. 10..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

protocol KlondikeView: AnyObject {
    
    func addPileStackView(count: Int)
    func removePileStackView(count: Int)
    
    func addPreviewStackView(cards: [Card])
    func removePreviewStackView(count: Int)
    
    func addColumnsStackView(cards: [Card], index: Int)
    func removeColumnsStackView(count: Int, index: Int, card: Card?)
    func initialSettingColumns(count: Int, index: Int, card: Card)
    
    func addGoalsStackView(cards: [Card], index: Int)
    func removeGoalsStackView(count: Int, index: Int)
}
