//
//  CardBackUIImageView.swift
//  CardGameApp
//
//  Created by oingbong on 26/10/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class CardUIImageView: UIImageView {
    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func reSize(with frame: CGRect) {
        let viewWidth = frame.width
        // 여유공간을 빼주기 위함 (즉, 전체화면의 10%를 더 빼고 카드넓이 계산)
        let viewWidthWithSpace = viewWidth - viewWidth * 0.1
        let imageWidth = viewWidthWithSpace / 7
        let widthRatio = CGFloat(1)
        let heightRatio = CGFloat(1.27)
        // newSize
        let newSize = CGSize(width: imageWidth * widthRatio, height: imageWidth * heightRatio)
        self.frame.size = newSize
    }
}
