//
//  CardPresentable.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 12..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

protocol CardPresentable {
    var cornerRadius: CGFloat { get }
    var clipToBounds: Bool { get }
    var borderColor: CGColor { get }
    var borderWidth: CGFloat { get }
}

extension CardPresentable {
    var cornerRadius: CGFloat {
        return 5
    }
    var clipToBounds: Bool {
        return true
    }
    var borderColor: CGColor {
        return UIColor.white.cgColor
    }
    var borderWidth: CGFloat {
        return 2
    }
}
