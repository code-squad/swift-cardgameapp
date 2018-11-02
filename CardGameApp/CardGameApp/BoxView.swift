//
//  BoxView.swift
//  CardGameApp
//
//  Created by oingbong on 31/10/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class BoxView: UIView {
    static let shared = BoxView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func defaultSetting() {
        guard let superView = self.superview else { return }
        let superWidth = superView.frame.width
        let superSpace = superWidth * Unit.tenPercentOfFrame
        let space = superSpace / Unit.spaceCount
        let width = (superWidth - superSpace) / Unit.cardCount
        let xValue = space * Unit.fromLeftSpace + width * Unit.fromLeftWidth
        reFrame(xValue: xValue)
        reSize(width: width)
    }
    
    private func reSize(width: CGFloat) {
        self.frame.size = CGSize(width: width * Unit.widthRatio, height: width * Unit.heightRatio)
    }
    
    private func reFrame(xValue: CGFloat) {
        self.frame = CGRect(x: xValue, y: Unit.reverseBoxYValue, width: self.frame.size.width, height: self.frame.size.height)
    }
}
