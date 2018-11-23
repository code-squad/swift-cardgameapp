//
//  DTO.swift
//  CardGameApp
//
//  Created by oingbong on 18/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

struct Delivery {
    var viewModel: DeliverableViewModel
    var view: DeliverableView
    var index: Int?
}

struct Destination {
    var viewModel: BasicViewModel
    var view: DestinationView
    var index: Int?
}

struct DragTargetInfo {
    var minX: Int
    var maxX: Int
    var minY: Int
    var maxY: Int
}
