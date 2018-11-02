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
    let moveToBox = "moveToBox"
    let restore = "restore"
    let getBack = "getBack"
}

struct Hash {
    let view = "view"
    let cardViewList = "cardViewList"
}
