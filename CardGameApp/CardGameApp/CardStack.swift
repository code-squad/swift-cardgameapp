//
//  CardStack.swift
//  CardGameApp
//
//  Created by oingbong on 12/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class CardStack {
    private var container: [UIView]
    
    init() {
        self.container = [UIView]()
    }
    
    func append(view: UIView) {
        self.container.append(view)
    }
    
    func addSubView(index: Int, view: UIView) {
        self.container[index].addSubview(view)
    }
    
    func removeSubView() {
        for containerView in self.container {
            for subView in containerView.subviews {
                subView.removeFromSuperview()
            }
        }
    }
}
