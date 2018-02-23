//
//  FoundationViews.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 1. 30..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class FoundationsView: UIView {
    var images: [String?] = [] {
        didSet {
            for i in 0..<images.count {
                guard let cardImage = images[i] else {
                    (self.subviews[i] as! UIImageView).image = nil
                    return
                }
                print(cardImage)
                (self.subviews[i] as! UIImageView).image = UIImage(named: cardImage)
            }
            setNeedsDisplay()
        }
    }

}
