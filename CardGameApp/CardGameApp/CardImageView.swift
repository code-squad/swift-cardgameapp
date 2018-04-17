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

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
        self.isUserInteractionEnabled = true
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

    func getBackSideImage() {
        self.image = UIImage(named: "card-back")
    }

    func getRefreshImage() {
        self.image = UIImage(named: "cardgameapp-refresh-app")
    }

}
