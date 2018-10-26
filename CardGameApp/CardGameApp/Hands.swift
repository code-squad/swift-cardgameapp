//
//  Hands.swift
//  CardGame
//
//  Created by oingbong on 2018. 9. 9..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

enum Hands {
    case nothing
    case onepair
    case twopair
    case triple
    case fourcard
}

extension Hands: Equatable, Comparable {
    static func == (lhs: Hands, rhs: Hands) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    static func < (lhs: Hands, rhs: Hands) -> Bool {
        return lhs.hashValue < rhs.hashValue
    }
    
    static func > (lhs: Hands, rhs: Hands) -> Bool {
        return lhs.hashValue > rhs.hashValue
    }
}
