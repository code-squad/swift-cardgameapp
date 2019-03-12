//
//  CardSpacesView.swift
//  CardGameApp
//
//  Created by 윤동민 on 05/03/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

class CardSpacesView: UIStackView {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetting()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetting()
    }

    convenience init(frame: CGRect, _ spacesView: [SpaceView]) {
        self.init(frame: frame)
        for spaceView in spacesView { addArrangedSubview(spaceView) }
    }
    
    private func initialSetting() {
        self.spacing = 5
        self.axis = .horizontal
        self.distribution = .fillEqually
    }
    
    func addCardView(at number: Int, view: CardView) {
        guard let spaceView = arrangedSubviews[number] as? SpaceView else { return }
        spaceView.addCardView(view)
    }
}
