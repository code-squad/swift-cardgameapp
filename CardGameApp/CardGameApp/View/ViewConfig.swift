//
//  ViewConfig.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 12..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

struct ViewConfig {
    let backgroundFile: String = "bg_pattern"
    let refreshFile: String = "cardgameapp-refresh-app"

    let normalSpacing: CGFloat = 4
    let cardSize: CGSize

    let foundationCount = 4
    let tableauCount = 7

    let tableauOrigin: CGPoint
    let foundationOrigin: CGPoint
    let spareOrigin: CGPoint
    let wasteOrigin: CGPoint

    init(on view: UIView) {
        let width = view.frame.size.width/7 - normalSpacing
        let height = width*1.27
        cardSize = CGSize(width: width, height: height)
        tableauOrigin = CGPoint(x: view.layoutMargins.left, y: view.layoutMargins.top+cardSize.height+15)
        foundationOrigin = CGPoint(x: view.layoutMargins.left, y: view.layoutMargins.top)
        spareOrigin = CGPoint(x: view.frame.width-(view.layoutMargins.right+cardSize.width)-normalSpacing,
                              y: view.layoutMargins.top)
        wasteOrigin = CGPoint(x: spareOrigin.x-cardSize.width*3/2-normalSpacing,
                              y: view.layoutMargins.top)
    }
}
