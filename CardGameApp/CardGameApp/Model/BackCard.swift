//
//  BackCard.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 3..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

// 카드 뒷면의 view와 상태를 갖고 있는 Data Object
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
