//
//  UIViewExtension.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 29..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

extension UIView {

    @discardableResult func makeEmptyView() -> UIView {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.clipsToBounds = true
        return self
    }
}

extension CardStackView {
    func fitLayout(with view: UIView, topConstant: CGFloat = 0) {
        self.setAutolayout()
        self.top(equal: view, constant: topConstant)
        self.leading(equal: view.leadingAnchor)
        self.trailing(equal:view.trailingAnchor)
        self.width(equal: view.widthAnchor)
        self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.27).isActive = true
    }

    func setAutolayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    func top(equal: UIView, constant: CGFloat = 0) {
        self.topAnchor.constraint(equalTo: equal.safeAreaLayoutGuide.topAnchor, constant: constant).isActive = true
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

extension Int {
    var cgfloat: CGFloat {
        return CGFloat(self)
    }
}
