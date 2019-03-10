//
//  Player.swift
//  CardGame
//
//  Created by 조재흥 on 18. 12. 7..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol GamePlayer: CustomStringConvertible {
    var description: String {get}
    func score() -> Int
}
