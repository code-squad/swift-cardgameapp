//
//  TableauContainerView.swift
//  CardGameApp
//
//  Created by oingbong on 12/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class TableauContainerView: UIView {
    // 카드몰드는 배열에도 속하지 않고 그냥 모양을 나타내기 위해 addSubView만 합니다.
    private var container = [UIView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        var xValue = Unit.space
        for _ in 0..<Unit.cardCountNumber {
            let mold = cardMold(xValue: xValue, yValue: 0)
            // 모델에서 추가할 때는 인덱스를 보고 추가하기 위해 배열에 넣어 사용합니다.
            self.addSubview(mold)
            let rect = CGRect(x: xValue, y: 0, width: Unit.imageWidth * Unit.widthRatio, height: self.frame.height)
            let container = UIView(frame: rect)
            self.addSubview(container)
            self.container.append(container)
            let newXValue = xValue + mold.frame.width + Unit.space
            xValue = newXValue
        }
    }
    
    private func cardMold(xValue: CGFloat, yValue: CGFloat) -> UIView {
        let rect = CGRect(x: xValue, y: yValue, width: Unit.imageWidth * Unit.widthRatio, height: Unit.imageWidth * Unit.heightRatio)
        let mold = UIView(frame: rect)
        mold.layer.borderWidth = Unit.foundationBorderWidth
        mold.layer.borderColor = Unit.foundationBorderColor
        return mold
    }
    
    func addTopSubView(index: Int, view: CardImageView) {
        let count = self.container[index].subviews.count
        let yValue = CGFloat(count) * Unit.cardSpace
        // 가장 마지막 카드 앞면 보이게 하기
        if count == index {
            view.turnOver()
        }
        view.frame.origin = CGPoint(x: 0, y: CGFloat(yValue))
        self.container[index].addSubview(view)
        addGestureCardView(with: view)
    }
    
    func removeAllSubView() {
        for containerView in self.container {
            for subView in containerView.subviews {
                subView.removeFromSuperview()
            }
        }
    }
}

extension TableauContainerView {
    private func addGestureCardView(with view: CardImageView) {
        let doubleTapGesture = UITapGestureRecognizer(target: view, action: #selector(view.dobuleTapActionTableau(tapGestureRecognizer:)))
        doubleTapGesture.numberOfTapsRequired = 2
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(doubleTapGesture)
    }
}
