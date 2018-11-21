//
//  Unit.swift
//  CardGameApp
//
//  Created by oingbong on 02/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

struct Unit {
    public static let refreshImage = "cardgameapp-refresh-app"
    public static let cardBack = "card-back"
    public static let bgPattern = "bg_pattern"
    public static let basePoint = CGPoint(x: 0, y: 0)
    public static let foundationYValue = CGFloat(20)
    public static let foundationCount = 4
    public static let foundationBorderWidth = CGFloat(1)
    public static let foundationBorderColor = UIColor.white.cgColor
    public static let cardSpace = CGFloat(20)
    public static let stockYValue = CGFloat(20)
    public static let defalutCardsYValue = CGFloat(100)
    public static let defalutSize = CGFloat(100)
    public static let tableauCount = 7
    public static let cardCount = CGFloat(7)
    public static let cardCountNumber = 7
    public static let tenPercentOfFrame = CGFloat(0.1)
    public static let widthRatio = CGFloat(1)
    public static let heightRatio = CGFloat(1.27)
    public static let spaceCount = CGFloat(8)
    public static let fromLeftSpaceOfStock = CGFloat(7)
    public static let fromLeftWidthOfStock = CGFloat(6)
    public static let fromLeftSpaceOfWaste = CGFloat(5.5)
    public static let fromLeftWidthOfWaste = CGFloat(4.5)
    public static let refreshRatio = CGFloat(0.3)
    public static let refreshPoint = CGFloat(0.5)
    public static let iphone8plusWidth = CGFloat(414)
    public static let iphone8plusHeight = CGFloat(736)
    private static let superSpace = iphone8plusWidth * tenPercentOfFrame
    public static let space = superSpace / spaceCount
    public static let cardWidth = (iphone8plusWidth - superSpace) / cardCount
    public static let stockXValue = space * fromLeftSpaceOfStock + cardWidth * fromLeftWidthOfStock
    public static let wasteXValue = space * fromLeftSpaceOfWaste + cardWidth * fromLeftWidthOfWaste
    
    private static let viewWidthWithoutSpace = iphone8plusWidth - iphone8plusWidth * tenPercentOfFrame
    public static let imageWidth = viewWidthWithoutSpace / cardCount
}
