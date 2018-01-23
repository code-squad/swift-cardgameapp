//
//  MoveInfo.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 16..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

struct StartInfo {
    var viewModel: MovableViewModel
    var index: Int
    var count: Int
}

struct TargetInfo {
    var viewModel: MovableViewModel
    var index: Int
}

struct MoveInfo {
    var startIndex: Int
    var targetIndex: Int
}

struct DragInfo {
    var changes = [UIView]()
    var originals = [CGPoint]()
    var startView: MovableView?
    var startPos: Position?
    var targetPos: Position?
}
