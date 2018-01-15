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

    func animate(from original: CGPoint,to viewPosition: CGPoint, action: @escaping (Bool) -> Void ) {
        UIView.animate(
            withDuration: 0.5,
            animations: {
                self.frame.origin.x = -original.x
                self.frame.origin.x += viewPosition.x
                self.frame.origin.y = -original.y
                self.frame.origin.y += viewPosition.y
        },
            completion: action
        )
    }
    
    func addTapGesture(_ target: Any?, action: Selector) {
        let tapRecognizer = UITapGestureRecognizer(target: target, action: action)
        tapRecognizer.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapRecognizer)
        self.isUserInteractionEnabled = true
    }

    func setGridLayout(_ views: [UIView], top: CGFloat = 0) {
        let widthOfCard = (self.frame.width - 24) / 7
        for i in 0..<views.count {
            self.addSubview(views[i])
            views[i].setRatio()
            views[i].top(equal: self, constant: top)
            if i==0 {
                views[i].leading(equal: self.leadingAnchor, constant: 3)
            } else {
                views[i].leading(equal: views[i-1].trailingAnchor, constant: 3)
            }
            views[i].width(constant: widthOfCard)
        }
    }

    @discardableResult func makeEmptyView() -> UIView {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.clipsToBounds = true
        return self
    }

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

extension UIImageView {

    func addDoubleTapGesture(_ target: Any?, action: Selector) {
        let tapRecognizer = UITapGestureRecognizer(target: target, action: action)
        tapRecognizer.numberOfTapsRequired = 2
        self.addGestureRecognizer(tapRecognizer)
        self.isUserInteractionEnabled = true
    }

}
