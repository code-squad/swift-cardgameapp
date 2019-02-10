//
//  CardSpacesView.swift
//  CardGameApp
//
//  Created by 윤지영 on 10/02/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

class CardSpacesView: UIStackView {

    required init(coder: NSCoder) {
        super.init(coder: coder)
        configureLayout()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }

    convenience init(frame: CGRect, spaces: Int) {
        self.init(frame: frame)
        createCardSpaceViews(spaces: spaces)
    }

    private func configureLayout() {
        spacing = 5
        distribution = .fillEqually
    }

    private func createCardSpaceViews(spaces: Int) {
        for _ in 0..<spaces {
            let cardSpaceView = CardSpaceView(frame: .zero)
            addArrangedSubview(cardSpaceView)
        }
    }

}
