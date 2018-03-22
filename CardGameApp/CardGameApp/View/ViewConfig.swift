//
//  ViewConfig.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 12..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

struct ViewConfig {
    private(set) var background: String = "bg_pattern"
    private(set) var horizontalStackSpacing: CGFloat = 4
    private(set) var tableauPosition: CGPoint
    private(set) var foundationPosition: CGPoint
    private(set) var sparePosition: CGPoint
    private(set) var wastePosition: CGPoint
    private(set) var cardSize: CGSize

    init(on view: UIView) {
        let width = view.frame.size.width/7
        let height = width*1.27
        cardSize = CGSize(width: width, height: height)
        tableauPosition = CGPoint(x: view.layoutMargins.left, y: view.layoutMargins.top+cardSize.height+15)
        foundationPosition = CGPoint(x: view.layoutMargins.left, y: view.layoutMargins.top)
        sparePosition =
            CGPoint(x: view.frame.width-(view.layoutMargins.right+cardSize.width)+horizontalStackSpacing,
                    y: view.layoutMargins.top)
        wastePosition =
            CGPoint(x: sparePosition.x-cardSize.width-horizontalStackSpacing,
                    y: view.layoutMargins.top)
    }
}
