//
//  CardImageMaker.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 12..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class CardImageView: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(frame: CGRect) { // by code
        super.init(frame: frame)
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }

    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func getImage(of card: ImageSelector) {
        self.image = UIImage(named: "\(card.Image)")
    }

    func getBackSide() {
        self.image = UIImage(named: "card-back")
    }

}
