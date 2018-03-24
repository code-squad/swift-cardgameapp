//
//  FoundationViewContainer.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 3. 23..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class FoundationViewContainer: UIView {
    private var foundationViews: [FoundationView] = []
    private var config: ViewConfig

    convenience init(frame: CGRect, config: ViewConfig) {
        self.init(frame: frame)
        self.config = config
        configureFoundationViews()
    }

    override init(frame: CGRect) {
        config = ViewConfig(on: UIView())
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        config = ViewConfig(on: UIView())
        super.init(coder: aDecoder)
    }

    func lay(card: CardView, on index: Int) {
        foundationViews[index].lay(card: card)
    }

    func remove(on index: Int) {
        foundationViews[index].removeLastCard()
    }

    func removeAllCards() {
        foundationViews.forEach { $0.removeAllSubviews() }
    }

    func at(_ index: Int) -> CanLayCards {
        return foundationViews[index]
    }

    private func configureFoundationViews() {
        (0..<config.foundationCount).forEach {
            let origin = CGPoint(x: CGFloat($0)*(config.cardSize.width+config.normalSpacing), y: 0)
            let foundationView = FoundationView(frame: CGRect(origin: origin, size: config.cardSize), index: $0)
            foundationViews.append(foundationView)
            addSubview(foundationView)
        }
    }

}
