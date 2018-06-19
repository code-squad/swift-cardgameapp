//
//  DeckViewable.swift
//  CardGameApp
//
//  Created by Jung seoung Yeo on 2018. 6. 19..
//  Copyright © 2018년 Clover. All rights reserved.
//

import UIKit

protocol CardViewable {
    var cardView: UIImageView { set get}
    
    func instance() -> CardViewable
    func setImage(with cardName: String) -> CardViewable
    func setContentMode(with contentmode: UIViewContentMode) -> CardViewable
    func setClipsToBounds(with bounds: Bool) -> CardViewable
    func setCornerRadius(with radius: CGFloat) -> CardViewable
}
