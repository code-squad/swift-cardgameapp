//
//  CardStackMovableView.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 16..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

protocol MovableView {
    func pop(index: Int, previousCard: Card?)
    func push(index: Int, cardViews: [CardView])

    func position(_ point: CGPoint) -> Position?
    func selectedView(_ position: Position) -> CardView?
    func coordinate(index: Int) -> CGPoint
    func targetCoordinate(index: Int) -> CGPoint

    func belowViews(_ position: Position) -> [UIView]
    func isLast(_ position: Position) -> Bool
}
