//
//  ColumnsView.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 3. 15..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

protocol ColumnsView: AnyObject {
    func addColumnsStackView(cards: [Card], index: Int)
    func removeColumnsStackView(count: Int, index: Int, card: Card?)
    func initialSettingColumns(count: Int, index: Int, card: Card)
}
