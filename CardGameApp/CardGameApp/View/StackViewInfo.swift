//
//  StackViewInfo.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 5..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

struct StackViewInfo: StackPresentable {
    private(set) var axis: UILayoutConstraintAxis
    private(set) var distribution: UIStackViewDistribution
    private(set) var spacing: CGFloat
    private(set) var bottomMargin: CGFloat
}
