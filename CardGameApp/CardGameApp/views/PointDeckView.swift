//
//  PointDeckView.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 2. 19..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit

class PointDeckView: UIStackView {

    // 기본 생성자
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
