//
//  BackCardView.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 3..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

class BackCardView: UIImageView {
    let refreshImage = UIImage(named: "cardgameapp-refresh-app")
    let backImage = UIImage(named: "card-back")

    var state: State = .normal {
        willSet(newVal) {
            switch newVal {
            case .normal: self.image = backImage
            case .refresh: self.image = refreshImage
            }
        }
    }
    enum State {
        case refresh
        case normal
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.image = backImage
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension BackCardView {
    func addGesture(_ target: Any?, action: Selector) {
        let tapRecognizer = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(tapRecognizer)
        self.isUserInteractionEnabled = true
    }
}
