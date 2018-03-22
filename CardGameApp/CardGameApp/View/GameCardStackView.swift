//
//  StackController.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 3. 5..
//  Copyright © 2018년 Napster. All rights reserved.
//

import UIKit

class GameCardStackView: UIView, CardGameView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tag = SubViewTag.gameCardStackView.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func makeStackBackView() {
        for column in 0..<7 {
            let stackView = UIView()
            stackView.makeStackView(column: column)
            stackView.tag = column
            self.addSubview(stackView)
        }
    }
    
    func removeStackViewLast(index: Int) {
        guard let lastView = self.subviews[index].subviews.last else { return }
        lastView.removeFromSuperview()
    }
    
    func pushStackViewLast(card: UIView) {
        self.addSubview(card)
    }
}
