//
//  NotificationKey.swift
//  CardGameApp
//
//  Created by oingbong on 02/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

struct NotificationKey {
    static let name = Name()
    static let hash = Hash()
}

struct Name {
    let moveToWaste = "moveToWaste"
    let restore = "restore"
    let doubleTap = "doubleTap"
    let stock = "stock"
    let waste = "waste"
    let foundation = "foundation"
    let tableau = "tableau"
}

struct Hash {
    let index = "index"
}
