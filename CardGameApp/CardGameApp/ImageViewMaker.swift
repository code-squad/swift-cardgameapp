//
//  CardImgViewMaker.swift
//  CardGameApp
//
//  Created by 권재욱 on 2018. 3. 21..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import Foundation
import UIKit

struct ImageViewMaker {
    
    private let screenWidth : CGFloat
    private let cardRatio = CGFloat(1.27)
    private let countOfCards = CGFloat(7)
    private let marginRatioValue = CGFloat(30)
    
    enum Position : CGFloat {
        case top = 20
        case bottom = 100
    }
    
    init(_ width : CGFloat) {
        self.screenWidth = width
    }
    
    func generateCardImgView(_ index : Int, _ position : Position, _ cardImg : UIImage, _ isEmpty : Bool) -> UIImageView {
        let width = screenWidth / countOfCards
        let margin = width / marginRatioValue
        let cardbackImgView = UIImageView(image : cardImg)
        cardbackImgView.frame = CGRect(origin: CGPoint(x: margin + CGFloat(index) * width ,y: position.rawValue) ,
                                       size: CGSize(width: width - margin, height: (width - margin) * cardRatio))
        cardbackImgView.contentMode = .scaleAspectFit
        cardbackImgView.clipsToBounds = true
        cardbackImgView.layer.cornerRadius = 5
        guard isEmpty == true else { return cardbackImgView }
        cardbackImgView.layer.borderColor = UIColor.white.cgColor
        cardbackImgView.layer.borderWidth = 1
        return cardbackImgView
    }
    
}
