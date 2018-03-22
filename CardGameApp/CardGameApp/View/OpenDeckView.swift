//
//  OpenDeckView.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 3. 12..
//  Copyright © 2018년 Napster. All rights reserved.
//

import UIKit

class OpenDeckView: UIView, CardGameView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tag = SubViewTag.openDeckView.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func removeStackViewLast(index: Int) {
        guard let lastView = self.subviews[0].subviews.last else { return }
        lastView.removeFromSuperview()
    }
    
    func makeBasicSubView() {
        let basicView = UIView()
        basicView.makeCardView()
        basicView.makeZeroOrigin()
        self.addSubview(basicView)
    }
}
