//
//  ImgFrameMaker.swift
//  CardGameApp
//
//  Created by 권재욱 on 2018. 3. 26..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import Foundation
import UIKit

protocol FrameControl {
    func generateCardStacksViewFrame() -> CGRect
    func generateCardViewFrame(_ cardInfo: CardInfo) -> CGRect
    func generateIndex(_ cardView: UIImageView) -> CardInfo
}

struct ImgFrameMaker : FrameControl {

    private let screenWidth : CGFloat
    private let width : CGFloat
    private let margin : CGFloat
    private let cardRatio = CGFloat(1.27)
    private let countOfCards = CGFloat(7)
    private let marginRatioValue = CGFloat(30)
    private let stackMargin = CGFloat(20)
    private let cardStack = CGFloat(0)
    
    
    enum Position : CGFloat {
        case top = 20
        case cardStacks = 100
    }
    
    init(_ screenWidth : CGFloat) {
        self.screenWidth = screenWidth
        self.width = self.screenWidth / countOfCards
        self.margin = self.width / marginRatioValue
    }
    
    func generateCardStacksViewFrame() -> CGRect {
        return CGRect(origin: CGPoint(x: cardStack, y: cardStack),
                      size: CGSize(width: self.screenWidth - margin, height: (width - margin) * countOfCards))
    }
    
    func generateCardViewFrame(_ cardInfo: CardInfo) -> CGRect {
        let cardSize = CGSize(width: width - margin, height: (width - margin) * cardRatio)
        let cardOrigin = CGPoint(x: margin + CGFloat(cardInfo.indexOfCard) * width ,y: cardInfo.position.rawValue + stackMargin * CGFloat(cardInfo.stackIndex))
        return CGRect(origin: cardOrigin, size: cardSize)
    }
    
    func generateIndex(_ cardView: UIImageView) -> CardInfo {
        let indexOfCard: Int = Int(cardView.frame.origin.x / width)
        var position : Position {
            guard cardView is OpenedCardView else { return Position.cardStacks}
            return Position.top
        }
        let stackIndex: Int = Int(round((cardView.frame.origin.y - ImgFrameMaker.Position.cardStacks.rawValue) / stackMargin))
        return CardInfo(indexOfCard, stackIndex, position);
    }
    
}
