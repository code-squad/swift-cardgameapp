//
//  SpareView.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 13..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class SpareView: CardView {
    convenience init(_ config: ViewConfig) {
        let size = CGSize(width: config.cardSize.width-config.horizontalStackSpacing, height: config.cardSize.height)
        self.init(frame: CGRect(origin: config.sparePosition, size: size))
        self.setBorderState(to: .hide)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
