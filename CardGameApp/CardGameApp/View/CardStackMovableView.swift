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

    func position(pos: CGPoint) -> Position?
    func selectedView(pos: Position) -> CardView?
    func coordinate(index: Int) -> CGPoint?
    func targetCoordinate(index: Int) -> CGPoint?

    func belowViews(pos: Position) -> [UIView]?
    func isLast(pos: Position) -> Bool
}
