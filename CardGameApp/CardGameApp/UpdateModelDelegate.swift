//
//  UpdateModelDelegate.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 3. 25..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

protocol UpdateModelDelegate: class {
    func refreshWaste()

    func move(cardViewModel: CardViewModel, from startLocation: Location, to endLocation: Location)

    func update(cardViewModel: CardViewModel, to endLocation: Location)
}
