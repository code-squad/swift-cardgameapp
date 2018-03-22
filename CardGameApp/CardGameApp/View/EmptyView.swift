//
//  EmptyView.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 3. 22..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class EmptyView: UIImageView, CardPresentable {

    convenience init(frame: CGRect, hasBorder: Bool) {
        self.init(frame: frame)
        self.layer.borderWidth = (hasBorder) ? 2 : 0
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = clipToBounds
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
