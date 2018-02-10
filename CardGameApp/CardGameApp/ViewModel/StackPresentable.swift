//
//  StackConfigurable.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 7..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

protocol StackPresentable {
    var axis: UILayoutConstraintAxis { get }
    var distribution: UIStackViewDistribution { get }
    var spacing: CGFloat { get }
    var bottomMargin: CGFloat { get }
}
