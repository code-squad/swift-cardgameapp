//
//  CardStackView.swift
//  CardGameApp
//
//  Created by 윤지영 on 28/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

class CardStackView: UIStackView {

    func addAllSubviews(_ addSubview: (UIView) -> Void) {
        arrangedSubviews.forEach { addSubview($0) }
    }

}
