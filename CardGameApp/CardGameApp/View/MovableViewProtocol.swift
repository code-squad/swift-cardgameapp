//
//  MovableViewProtocol.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 16..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

protocol ViewInfo {
    func position(_ point: CGPoint) -> Position?
}

protocol MovableTargetView: ViewInfo {
    func push(index: Int, cardViews: [CardView])
    func targetCoordinate(index: Int) -> CGPoint
}

protocol MovableStartView: ViewInfo {
    func isLast(_ position: Position) -> Bool
    func selectedView(_ position: Position) -> CardView?
    func belowViews(_ position: Position) -> [UIView]
    func coordinate(index: Int) -> CGPoint
}
