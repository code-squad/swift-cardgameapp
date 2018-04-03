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
    private let width : CGFloat
    private let margin : CGFloat
    private let cardRatio = CGFloat(1.27)
    private let countOfCards = CGFloat(7)
    private let marginRatioValue = CGFloat(30)
    private let stackMargin = CGFloat(20)
    
    
    enum Position : CGFloat {
        case top = 20
        case bottom = 100
        
    }
    
    init(_ screenWidth : CGFloat) {
        self.screenWidth = screenWidth
        self.width = self.screenWidth / countOfCards
        self.margin = self.width / marginRatioValue
    }
    
    func generateCardStacksViewFrame() -> CGRect {
        return CGRect(origin: CGPoint(x: margin, y: Position.bottom.rawValue), size: CGSize(width: self.screenWidth - margin, height: (width - margin) * countOfCards))
    }
    
    func generateFrame(_ indexOfCard: Int,_ stackIndex: Int, _ position: Position) -> CGRect {
        let cardSize = CGSize(width: width - margin, height: (width - margin) * cardRatio)
        let cardOrigin = CGPoint(x: margin + CGFloat(indexOfCard) * width ,y: position.rawValue + stackMargin * CGFloat(stackIndex))
        return CGRect(origin: cardOrigin, size: cardSize)
    }
    
    func generateStackFrame(_ indexOfCard: Int,_ stackIndex: Int, _ position: Position) -> CGRect {
        let cardSize = CGSize(width: width - margin, height: (width - margin) * cardRatio)
        let cardOrigin = CGPoint(x: margin + CGFloat(indexOfCard) * width ,y: stackMargin * CGFloat(stackIndex))
        return CGRect(origin: cardOrigin, size: cardSize)
    }
    
    func generateIndex(_ rect: CGRect) -> (Int, Int, Position) {
        let indexOfCard = (rect.origin.x - margin) / width
        var position : Position {
            guard rect.origin.y < CGFloat(100) else { return Position.bottom }
            return Position.top
        }
        let stackIndex = ( rect.origin.y - position.rawValue ) / stackMargin
        return (Int(indexOfCard), Int(stackIndex), position)
    }
    
}
