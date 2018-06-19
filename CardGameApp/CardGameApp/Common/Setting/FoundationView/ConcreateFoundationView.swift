//
//  ConcreateFoundationView.swift
//  CardGameApp
//
//  Created by Jung seoung Yeo on 2018. 6. 18..
//  Copyright © 2018년 Clover. All rights reserved.
//

// Concreate Builder
import UIKit

class ConcreateFoundationView: FoundationViewable {
    
    var foundationView: UIImageView = UIImageView()
    
    func instance() -> FoundationViewable {
        self.foundationView = UIImageView()
        return self
    }
    
    func setBorderColor(with cgcolor: CGColor) -> FoundationViewable {
        self.foundationView.layer.borderColor = cgcolor
        return self
    }
    
    func setBorderWith(with cgfloat: CGFloat) -> FoundationViewable {
        self.foundationView.layer.borderWidth = cgfloat
        return self
    }
    
    func setContentMode(with contentmode: UIViewContentMode) -> FoundationViewable {
        self.foundationView.contentMode = contentmode
        return self
    }
    
    func setClipsToBounds(with bounds: Bool) -> FoundationViewable {
        self.foundationView.clipsToBounds = bounds
        return self
    }
    
    func setCornerRadius(with radius: CGFloat) -> FoundationViewable {
        self.foundationView.layer.cornerRadius = radius
        return self
    }
    
}
