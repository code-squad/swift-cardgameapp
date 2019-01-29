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
    let sizeRatio: CGFloat
    let overlap: CGFloat
    let sideMargin: CGFloat
    let firstSideMarginRatio: CGFloat
    let firstTopMargin: CGFloat
    let topMarginInterval: CGFloat
}

struct CardViewFactory {
    private let frameWidth: CGFloat
    private let viewSize: CGSize
    private let overlap: CGFloat

    private let sideMargin: CGFloat
    private let firstSideMarginRatio: CGFloat
    private let firstTopMargin: CGFloat
    private let topMarginInterval: CGFloat

    init(layout: CardViewLayout, frameWidth: CGFloat) {
        sideMargin = layout.sideMargin
        overlap = layout.overlap
        firstSideMarginRatio = layout.firstSideMarginRatio
        firstTopMargin = layout.firstTopMargin
        topMarginInterval = layout.topMarginInterval
        self.frameWidth = frameWidth
        let widthExceptMargin = frameWidth - sideMargin * CGFloat(layout.division + 2)
        let viewWidth = widthExceptMargin / CGFloat(layout.division)
        let viewHeight = viewWidth * layout.sizeRatio
        viewSize = CGSize(width: viewWidth, height: viewHeight)
    }

    enum Align: CGFloat {
        case left = 1
        case right = -1
    }

    private func positionXOfFirstView(at column: Int = 1, aligned align: Align) -> CGFloat {
        let move = (viewSize.width + sideMargin) * CGFloat(column - 1)
        let positionX = sideMargin * firstSideMarginRatio
        if align == .right {
            return frameWidth - viewSize.width - positionX - move
        }
        return positionX + move
    }

    private func createStackView(by imageNames: [String?], at point: CGPoint) -> CardStackView {
        let cardStackView = CardStackView()
        var positionY = point.y
        for imageName in imageNames {
            let origin = CGPoint(x: point.x, y: positionY)
            let cardView = CardView(origin: origin, size: viewSize)
            cardView.setImage(named: imageName)
            cardStackView.addCardView(cardView)
            positionY += overlap
        }
        return cardStackView
    }

    func createStackViews(of stacks: CardStacks, align: Align = .left) -> CardStacksView {
        let cardStacksView = CardStacksView()
        let topMargin = firstTopMargin + topMarginInterval
        var positionX = positionXOfFirstView(aligned: align)
        let direction = align.rawValue
        for imageNames in stacks.imageNames {
            let origin = CGPoint(x: positionX, y: topMargin)
            let cardStackView = createStackView(by: imageNames, at: origin)
            cardStacksView.addCardStackView(cardStackView)
            positionX += (viewSize.width + sideMargin) * direction
        }
        return cardStacksView
    }

    func createDeckView(of cardDeck: CardDeck?, at column: Int = 1, align: Align = .left) -> CardStackView {
        
        let positionX = positionXOfFirstView(at: column, aligned: align)
        let origin = CGPoint(x: positionX, y: firstTopMargin)
        let frame = CGRect(origin: origin, size: viewSize)
        
        let cardStackView = CardStackView(frame: frame)
        guard let cardDeck = cardDeck else { return cardStackView }
        while !cardDeck.isEmpty {
            guard let card = cardDeck.removeOne() else { break }
            let cardViewModel = CardViewModel(card: card)
            let cardView = CardView(size: viewSize)
            cardView.viewModel = cardViewModel
            cardStackView.addCardView(cardView)
        }
        
        return cardStackView
    }

    func createSpaceViews(spaces: Int, align: Align = .left) -> [CardSpaceView] {
        var cardSpaceViews: [CardSpaceView] = []
        var positionX = positionXOfFirstView(aligned: align)
        let direction = align.rawValue
        for _ in 0..<spaces {
            let origin = CGPoint(x: positionX, y: firstTopMargin)
            let cardSpaceView = CardSpaceView(origin: origin, size: viewSize)
            cardSpaceViews.append(cardSpaceView)
            positionX += (viewSize.width + sideMargin) * direction
        }
        return cardSpaceViews
    }

}
