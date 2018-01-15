//
//  CardStackMovableModel.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 16..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

protocol CardStackMovableModel {
    func top(index: Int) -> Card?
    func pop(index: Int) -> Card?
    func push(index: Int, card: Card)
}
