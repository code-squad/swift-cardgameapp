//
//  CardViewFactory.swift
//  CardGameApp
//
//  Created by 윤지영 on 28/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

struct CardGameViewLayout {

    private struct Margin {
        static let side: CGFloat = 5
        static let top: CGFloat = 20
        static let topInterval: CGFloat = 80
    }

    private let frame: CGRect
    private let numberOfCardStacks: CGFloat
    private let cardViewSize: CGSize

    init(frame: CGRect, numberOfCardStacks: Int = 7) {
        self.frame = frame
        self.numberOfCardStacks = CGFloat(numberOfCardStacks)
        let widthExceptMargin = frame.width - Margin.side * (self.numberOfCardStacks + 2)
        let cardViewWidth = widthExceptMargin / self.numberOfCardStacks
        let cardViewHeight = cardViewWidth * 1.27
        self.cardViewSize = CGSize(width: cardViewWidth, height: cardViewHeight)
    }

    var frameOfCardStacksView: CGRect {
        let origin = CGPoint(x: Margin.side, y: Margin.top + Margin.topInterval)
        let size = CGSize(width: frame.width - 2 * Margin.side, height: cardViewSize.height * numberOfCardStacks)
        return CGRect(origin: origin, size: size)
    }

    var frameOfCardDeckView: CGRect {
        let origin = CGPoint(x: frame.width - cardViewSize.width - Margin.side, y: Margin.top)
        let size = cardViewSize
        return CGRect(origin: origin, size: size)
    }

    var frameOfCardPileView: CGRect {
        let origin = CGPoint(x: frame.width - 2 * (cardViewSize.width + Margin.side), y: Margin.top)
        let size = cardViewSize
        return CGRect(origin: origin, size: size)
    }

    func getFrameOfCardSpacesView(spaces: Int) -> CGRect {
        let spaces = CGFloat(spaces)
        let origin = CGPoint(x: Margin.side, y: Margin.top)
        let size = CGSize(width: cardViewSize.width * spaces + Margin.side * (spaces-1), height: cardViewSize.height)
        return CGRect(origin: origin, size: size)
    }

}
