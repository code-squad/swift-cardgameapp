//
//  Playable.swift
//  CardGame
//
//  Created by 윤지영 on 13/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol Playable {
    func count() -> Int
    mutating func shuffle()
    mutating func removeOne() -> Card?
    mutating func reset()
}
