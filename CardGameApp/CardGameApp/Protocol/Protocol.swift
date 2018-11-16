//
//  Protocol.swift
//  CardGameApp
//
//  Created by oingbong on 16/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

protocol DeliverableViewModel {
    func pop(index: Int?) -> Card?
}

protocol DeliverableView {
    func removeTopSubView(index: Int?)
}
