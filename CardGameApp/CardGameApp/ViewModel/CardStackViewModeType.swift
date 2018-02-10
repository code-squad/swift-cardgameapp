//
//  CardStackViewModel.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 7..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

protocol CardStackViewModelType {
    func laidCardViewModels() -> [CardViewModel]
    func set(card: Card)
}
