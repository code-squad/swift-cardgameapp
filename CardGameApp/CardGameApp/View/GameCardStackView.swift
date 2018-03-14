//
//  StackController.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 3. 5..
//  Copyright © 2018년 Napster. All rights reserved.
//

import UIKit

class GameCardStackView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    func removeStackViewLast(cardView: UIView) {
        cardView.removeFromSuperview()
    }
    
    func pushStackViewLast(card: UIView) {
        self.addSubview(card)
    }
}
