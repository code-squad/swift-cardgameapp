//
//  CardStackPresentable.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 3. 22..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

protocol CardStackPresentable {
    var cardViewModels: [CardViewModel] { get }

    func append(_ card: Card?)

    func remove()
}
