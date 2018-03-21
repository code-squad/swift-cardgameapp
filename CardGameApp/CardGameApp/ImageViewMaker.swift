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
    private var margin : CGFloat!
    private let statusBarMargin = CGFloat(30)
    private let cardRatio = CGFloat(1.27)
    
    init(_ width : CGFloat) {
        self.screenWidth = width
    }
    
    mutating func generateCardbackImgView(_ index : Int) -> UIImageView {
        let width = screenWidth / 7
        margin = width / 30
        let cardbackImgView = UIImageView(image : UIImage(named : "card-back"))
        cardbackImgView.frame = CGRect(origin: CGPoint(x: margin + CGFloat(index) * width ,y: statusBarMargin) ,
                                       size: CGSize(width: width - margin, height: (width - margin) * cardRatio))
        cardbackImgView.contentMode = .scaleAspectFit
        cardbackImgView.clipsToBounds = true
        cardbackImgView.layer.cornerRadius = 5
        return cardbackImgView
    }
    
}
