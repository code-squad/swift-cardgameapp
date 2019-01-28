//
//  CardViewFactory.swift
//  CardGameApp
//
//  Created by 윤지영 on 28/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

struct CardViewLayout {
    let division: Int
    let sideMargin: CGFloat
    let firstSideMarginRatio: CGFloat
    let firstTopMargin: CGFloat
    let topMarginInterval: CGFloat
}

struct CardViewFactory {
    private let frameWidth: CGFloat
    private let division: Int
    private let sideMargin: CGFloat
    private let firstSideMarginRatio: CGFloat
    private let firstTopMargin: CGFloat
    private let topMarginInterval: CGFloat

    init(layout: CardViewLayout, frameWidth: CGFloat) {
        self.frameWidth = frameWidth
        division = layout.division
        sideMargin = layout.sideMargin
        firstSideMarginRatio = layout.firstSideMarginRatio
        firstTopMargin = layout.firstTopMargin
        topMarginInterval = layout.topMarginInterval
    }

    enum Align: CGFloat {
        case left = 1
        case right = -1
    }

    private var viewWidth: CGFloat {
        let widthExceptMargin = frameWidth - sideMargin * CGFloat(division + 2)
        return widthExceptMargin / CGFloat(division)
    }

    private func calculateTopMargin(of line: Int) -> CGFloat {
        return firstTopMargin + topMarginInterval * CGFloat(line - 1)
    }

    private func positionXOfFirstView(of width: CGFloat, aligned align: Align) -> CGFloat {
        var positionX = sideMargin * firstSideMarginRatio
        if align == .right {
            positionX = frameWidth - width - positionX
        }
        return positionX
    }

    func createImageViews(of cards: CardStack, line: Int, align: Align = .left) -> [CardImageView] {
        var cardImageViews: [CardImageView] = []
        let width = viewWidth
        let topMargin = calculateTopMargin(of: line)
        var positionX = positionXOfFirstView(of: width, aligned: align)
        let direction = align.rawValue
        for imageName in cards.imageNames {
            let origin = CGPoint(x: positionX, y: topMargin)
            let cardImageView = CardImageView(origin: origin, width: width)
            cardImageView.setImage(named: imageName)
            cardImageViews.append(cardImageView)
            positionX += (width + sideMargin) * direction
        }
        return cardImageViews
    }

    func createSpaceViews(spaces: Int, line: Int, align: Align = .left) -> [CardSpaceView] {
        var cardSpaceViews: [CardSpaceView] = []
        let width = viewWidth
        let topMargin = calculateTopMargin(of: line)
        var positionX = positionXOfFirstView(of: width, aligned: align)
        let direction = align.rawValue
        for _ in 0..<spaces {
            let origin = CGPoint(x: positionX, y: topMargin)
            let cardSpaceView = CardSpaceView(origin: origin, width: width)
            cardSpaceViews.append(cardSpaceView)
            positionX += (width + sideMargin) * direction
        }
        return cardSpaceViews
    }

}
