//
//  CardBackUIImageView.swift
//  CardGameApp
//
//  Created by oingbong on 26/10/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class CardUIImageView: UIImageView {
    private let countCard = CGFloat(7)
    private let tenPercentOfFrame = CGFloat(0.1)
    private let widthRatio = CGFloat(1)
    private let heightRatio = CGFloat(1.27)
    private var card = Card(number: .ace, shape: .heart)
    
    init(card: Card, frame: CGRect) {
        super.init(image: card.image())
        self.card = card
        self.frame = frame
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction(tapGestureRecognizer:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func reSize(with frame: CGRect) {
        let viewWidth = frame.width
        // 여유공간을 빼주기 위함 (즉, 전체화면의 10%를 더 빼고 카드넓이 계산)
        let viewWidthWithSpace = viewWidth - viewWidth * tenPercentOfFrame
        let imageWidth = viewWidthWithSpace / countCard
        // newSize
        let newSize = CGSize(width: imageWidth * widthRatio, height: imageWidth * heightRatio)
        self.frame.size = newSize
    }
    
    @objc private func tapAction(tapGestureRecognizer: UITapGestureRecognizer) {
        turnOver()
        moveToBox()
    }
    
    private func turnOver() {
        self.image = card.turnOver()
    }
    
    private func moveToBox() {
        guard self.superview is ReverseBoxView, let superView = self.superview else { return }
        guard superView.subviews.count > 0 else { return }
        let topView = superView.subviews[superView.subviews.count - 1]
        BoxView.shared.addSubview(topView)
    }
}
