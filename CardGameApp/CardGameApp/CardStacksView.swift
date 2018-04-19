//
//  CardStacksView.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 19..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class CardStacksView: UIView {

    private var stackImages: [[CardImageView]] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
    }

    convenience init(stackImages: [[CardImageView]]) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.stackImages = stackImages
        drawStacks()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    func drawStacks() {
        for i in 0..<stackImages.count {
            for j in 0..<stackImages[i].count {
                addSubview(stackImages[i][j])
            }
        }
    }
}

