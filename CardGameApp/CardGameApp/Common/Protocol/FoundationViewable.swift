//
//  FoundationViewable.swift
//  CardGameApp
//
//  Created by Jung seoung Yeo on 2018. 6. 18..
//  Copyright © 2018년 Clover. All rights reserved.
//

// builder
import UIKit

protocol FoundationViewable {
    
    var foundationView: UIImageView { set get}
    
    func instance() -> FoundationViewable
    func setBorderColor(with cgcolor: CGColor) -> FoundationViewable
    func setBorderWith(with cgfloat: CGFloat) -> FoundationViewable
    func setContentMode(with contentmode: UIViewContentMode) -> FoundationViewable
    func setClipsToBounds(with bounds: Bool) -> FoundationViewable
    func setCornerRadius(with radius: CGFloat) -> FoundationViewable
}
