//
//  ReversedCardsView.swift
//  CardGameApp
//
//  Created by 윤동민 on 21/02/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

class ReversedCardsView: UIView {
    var reversedViews: [CardView]
    
    required init?(coder aDecoder: NSCoder) {
        reversedViews = []
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
    }
    
    override init(frame: CGRect) {
        reversedViews = []
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    func addView(_ view: CardView) {
        reversedViews.append(view)
        addSubview(view)
    }
    
    func acceesTopView(form: (CardView) -> Void) {
        form(reversedViews[reversedViews.count-1])
    }
    
    func removeView() -> CardView? {
        guard reversedViews.count != 0 else { return nil }
        let removeView = reversedViews.remove(at: reversedViews.count-1)
        removeView.removeFromSuperview()
        return removeView
    }
}
