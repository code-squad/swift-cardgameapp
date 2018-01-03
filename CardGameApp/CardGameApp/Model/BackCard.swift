//
//  BackCard.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 3..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

struct BackCard {
    let refreshImage = UIImage(named: "cardgameapp-refresh-app")
    let backImage = UIImage(named: "card-back")

    var view = UIImageView()
    var state: State = .normal

    enum State {
        case refresh
        case normal
    }
}
