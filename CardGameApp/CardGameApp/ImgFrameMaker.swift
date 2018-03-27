//
//  ImgFrameMaker.swift
//  CardGameApp
//
//  Created by 권재욱 on 2018. 3. 26..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import Foundation
import UIKit

struct ImgFrameMaker {
    
    private let screenWidth : CGFloat
    private let cardRatio = CGFloat(1.27)
    private let countOfCards = CGFloat(7)
    private let marginRatioValue = CGFloat(30)
    private let stackMargin = CGFloat(20)
    
    
    enum Position : CGFloat {
        case top = 20
        case bottom = 100
    }
    
    enum indexOfCard : Int {
        case last = 6
        case openedCard = 5
    }
    
    init(_ width : CGFloat) {
        self.screenWidth = width
    }
    
    func generateFrame(_ indexOfCard: indexOfCard,_ stackIndex: Int, position: Position) -> CGRect {
        let width = screenWidth / countOfCards
        let margin = width / marginRatioValue
        let cardSize = CGSize(width: width - margin, height: (width - margin) * cardRatio)
        let cardOrigin = CGPoint(x: margin + CGFloat(indexOfCard.rawValue) * width ,y: position.rawValue + stackMargin * CGFloat(stackIndex))
        return CGRect(origin: cardOrigin, size: cardSize)
    }
}
