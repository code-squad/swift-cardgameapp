//
//  CardStackMovableView.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 16..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

protocol CardStackMovableView {
    func pop(index: Int, previousCard: Card?)
    func push(index: Int, cardView: CardView)
}
