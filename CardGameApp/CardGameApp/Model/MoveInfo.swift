//
//  MoveInfo.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 16..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

protocol StartInfo {
    var view: CardStackMovableView { get }
    var viewModel: CardStackMovableModel { get }
    var index: Int { get }
}

struct StartModel: StartInfo {
    var view: CardStackMovableView
    var viewModel: CardStackMovableModel
    var index: Int
}

protocol EndInfo {
    var view: CardStackMovableView { get }
    var viewModel: CardStackMovableModel { get }
    var index: Int { get }
}

struct EndModel: EndInfo {
    var view: CardStackMovableView
    var viewModel: CardStackMovableModel
    var index: Int
}
