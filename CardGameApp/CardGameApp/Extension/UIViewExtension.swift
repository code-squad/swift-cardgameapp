//
//  UIViewExtension.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 29..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

extension UIView {
    @discardableResult func makeEmptyView() -> UIView {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.clipsToBounds = true
        return self
    }
}

extension Int {
    var cgfloat: CGFloat {
        return CGFloat(self)
    }
}
