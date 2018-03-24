//
//  CardViewActionDelegate.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 13..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

protocol CardViewActionDelegate: class {
    func onSpareViewTapped(tappedView: CardView)
    
    func onCardViewDoubleTapped(tappedView: CardView)
}
