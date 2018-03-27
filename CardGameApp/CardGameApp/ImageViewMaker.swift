//
//  CardImgViewMaker.swift
//  CardGameApp
//
//  Created by 권재욱 on 2018. 3. 21..
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
    
    init(_ width : CGFloat) {
        self.screenWidth = width
    }
    
    func generateLocationOfCard(_ screenWidth: CGFloat, _ index: Int, stackIndex: Int, _ position: Position) -> CGRect {
        let width = screenWidth / Key.Frame.cardRatio.value
        let margin = width / Key.Frame.marginRatio.value
        let cardSize = CGSize(width: width - margin, height: (width - margin) * cardRatio)
        let cardOrigin = CGPoint(x: margin + CGFloat(index) * width ,y: position.rawValue + stackMargin * CGFloat(stackIndex))
        return CGRect(origin: cardOrigin, size: cardSize)
    }
    
//    func generateCardImgView(_ index: Int, _ stackIndex : Int, _ position: Position, _ cardImg: UIImage, _ isEmpty: Bool) -> UIImageView {
//        let width = screenWidth / countOfCards
//        let margin = width / marginRatioValue
//        let cardSize = CGSize(width: width - margin, height: (width - margin) * cardRatio)
//        let cardOrigin = CGPoint(x: margin + CGFloat(index) * width ,y: position.rawValue + stackMargin * CGFloat(stackIndex))
//        let cardbackImgView = UIImageView(image : cardImg)
//        cardbackImgView.frame = CGRect(origin: cardOrigin, size: cardSize)
//        cardbackImgView.contentMode = .scaleAspectFit
//        cardbackImgView.clipsToBounds = true
//        cardbackImgView.layer.cornerRadius = 5
//        guard isEmpty == true else { return cardbackImgView }
//        cardbackImgView.layer.borderColor = UIColor.white.cgColor
//        cardbackImgView.layer.borderWidth = 1
//        return cardbackImgView
//    }
    
}
