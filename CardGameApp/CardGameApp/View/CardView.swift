//
//  CardView.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 12..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

class CardView: UIImageView {

    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: Size.cardWidth, height: Size.cardHeight))
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension CardView {
    func fitLayout(with view: UIView, topConstant: CGFloat = 0) {
        self.setAutolayout()
        self.top(equal: view.topAnchor, constant: topConstant)
        self.leading(equal: view.leadingAnchor)
        self.trailing(equal: view.trailingAnchor)
        self.width(equal: view.widthAnchor)
        self.height(equal: view.widthAnchor, multiplier: 1.27)
    }

    func setAutolayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    func top(equal: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) {

        self.topAnchor.constraint(equalTo: equal, constant: constant).isActive = true
    }

    func leading(equal: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        self.leadingAnchor.constraint(equalTo: equal, constant: constant).isActive = true
    }

    func trailing(equal: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        self.trailingAnchor.constraint(equalTo: equal, constant: constant).isActive = true
    }

    func width(equal: NSLayoutAnchor<NSLayoutDimension>) {
        self.widthAnchor.constraint(equalTo: equal).isActive = true
    }

    func width(constant: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
    }

    func height(equal: NSLayoutDimension, multiplier: CGFloat = 0) {
        self.heightAnchor.constraint(equalTo: equal, multiplier: multiplier).isActive = true
    }
}
