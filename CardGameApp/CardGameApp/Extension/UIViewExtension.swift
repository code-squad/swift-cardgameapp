//
//  UIViewExtension.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 29..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

protocol CardViewLayoutProtocol {
    func setRatio()
}

extension UIView: CardViewLayoutProtocol {
    func setRatio() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.27).isActive = true
    }
}

extension UIView {
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

    func height(equal: UIView, multiplier: CGFloat) {
        self.heightAnchor.constraint(equalTo: equal.heightAnchor, multiplier: multiplier).isActive = true
    }
}
