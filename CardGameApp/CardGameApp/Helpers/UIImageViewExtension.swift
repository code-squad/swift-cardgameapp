//
//  UIImageViewExtension.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 8..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

extension UIImageView {
    // 카드크기 일정하게 제약
    func setCardSizeTo(_ size: CGSize) {
        self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
    }

    // 카드 테두리 설정
    func setDefaultCardBorderStyle(showBorder: Bool) {
        self.layer.cornerRadius = DeckViewModel.CardPresentable.cornerRadius
        self.clipsToBounds = DeckViewModel.CardPresentable.clipToBounds
        if showBorder {
            self.layer.borderColor = DeckViewModel.CardPresentable.borderColor
            self.layer.borderWidth = DeckViewModel.CardPresentable.borderWidth
        }
    }
}
