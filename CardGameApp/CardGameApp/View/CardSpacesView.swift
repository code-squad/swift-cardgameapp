//
//  CardSpacesView.swift
//  CardGameApp
//
//  Created by 윤지영 on 10/02/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

class CardSpacesView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(frame: CGRect, spaces: Int) {
        self.init(frame: frame)
        createCardSpaceViews(spaces: spaces)
    }

    private func createCardSpaceViews(spaces: Int) {
        var positionX: CGFloat = 0
        for _ in 0..<spaces {
            let origin = CGPoint(x: positionX, y: 0)
            let size = CGSize(width: 53, height: frame.height) // 수정
            let cardSpaceView = CardSpaceView(origin: origin, size: size)
            addSubview(cardSpaceView)
            positionX += cardSpaceView.frame.width + 5
        }
    }

}
