//
//  CardImageView.swift
//  CardGameApp
//
//  Created by 윤지영 on 23/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

class CardImageView: UIImageView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage()
        roundCorners()
    }

    convenience init(origin: CGPoint, width: CGFloat) {
        let size = CGSize(width: width, height: width * 1.27)
        let frame = CGRect(origin: origin, size: size)
        self.init(frame: frame)
    }

    private func setImage() {
        guard let image = UIImage(named: "card-back.png") else { return }
        self.image = image
    }

    private func roundCorners() {
        layer.cornerRadius = 4
        layer.masksToBounds = true
    }

}
