//
//  State.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 12..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

enum SpaceState {
    case vacant
    case exist(Observable<Card>)
}
