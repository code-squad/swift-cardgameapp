//
//  ReverseBoxView.swift
//  CardGameApp
//
//  Created by oingbong on 30/10/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class ReverseBoxView: UIView {
    static let shared = ReverseBoxView()
    private let cardCount = CGFloat(7)
    private let spaceCount = CGFloat(8)
    private let tenPercentOfFrame = CGFloat(0.1)
    private let widthRatio = CGFloat(1)
    private let heightRatio = CGFloat(1.27)
    private let reverseBoxYValue = CGFloat(20)
    private let fromLeftSpace = CGFloat(7)
    private let fromLeftWidth = CGFloat(6)
    private let refreshRatio = CGFloat(0.3)
    private let refreshPoint = CGFloat(0.5)
    private let refreshImageView = RefreshImageView(image: UIImage(named: "cardgameapp-refresh-app".formatPNG))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func defaultSetting() {
        guard let superView = self.superview else { return }
        let superWidth = superView.frame.width
        let superSpace = superWidth * tenPercentOfFrame
        let space = superSpace / spaceCount
        let width = (superWidth - superSpace) / cardCount
        let xValue = space * fromLeftSpace + width * fromLeftWidth
        reFrame(xValue: xValue)
        reSize(width: width)
        addRefresh()
    }
    
    private func reFrame(xValue: CGFloat) {
        self.frame = CGRect(x: xValue, y: reverseBoxYValue, width: self.frame.size.width, height: self.frame.size.height)
    }
    
    private func reSize(width: CGFloat) {
        self.frame.size = CGSize(width: width * widthRatio, height: width * heightRatio)
    }
    
    private func addRefresh() {
        self.addSubview(refreshImageView)
        refreshImageView.setting()
    }
}
