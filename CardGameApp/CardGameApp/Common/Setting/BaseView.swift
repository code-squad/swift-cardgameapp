//
//  BaseView.swift
//  CardGameApp
//
//  Created by Jung seoung Yeo on 2018. 6. 14..
//  Copyright © 2018년 Clover. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
    func setupView() {
        self.backgroundColor = UIColor(patternImage: .init(imageLiteralResourceName: "bg_pattern"))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
