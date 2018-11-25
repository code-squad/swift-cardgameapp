//
//  DTO.swift
//  CardGameApp
//
//  Created by oingbong on 18/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

struct Delivery {
    var viewModel: DeliverableViewModel
    var view: DeliverableView
    var index: Int?
    var subIndex: Int?
}

struct Destination {
    var viewModel: BasicViewModel
    var view: DestinationView
    var index: Int?
}

struct CoordinatesInfo {
    var selectedCardViews: [UIView]
    var selectedCard: Card
    var targetIndex: Int
    var target: Target
}

struct DragInfo {
    var recognizer: UIPanGestureRecognizer
    var originalCenters: [CGPoint]
    var delivery: Delivery
    var coordinatesInfo: CoordinatesInfo
}
