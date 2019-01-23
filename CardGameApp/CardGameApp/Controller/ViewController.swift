//
//  ViewController.swift
//  CardGameApp
//
//  Created by 윤지영 on 22/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        addCardImageViews()
    }

    private func setBackground() {
        guard let image = UIImage(named: "bg_pattern.png") else { return }
        self.view.backgroundColor = UIColor(patternImage: image)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func addCardImageViews() {
        let cardCreater = CardImageViewCreater(numberOfCards: 7, sideMargin: 5, topMargin: 40)
        let cards = cardCreater.createHorizontally(within: self.view.frame.width)
        cards.forEach { self.view.addSubview($0) }
    }

}

extension ViewController {

    private struct CardImageViewCreater {
        let numberOfCards: Int
        let sideMargin: CGFloat
        let topMargin: CGFloat

        private func calculateCardWidth(with frameWidth: CGFloat) -> CGFloat {
            return (frameWidth - sideMargin * CGFloat(numberOfCards + 2)) / CGFloat(numberOfCards)
        }

        func createHorizontally(within frameWidth: CGFloat) -> [CardImageView] {
            var cards: [CardImageView] = []
            let width = calculateCardWidth(with: frameWidth)
            var positionX = sideMargin * 1.5
            for _ in 1...numberOfCards {
                let origin = CGPoint(x: positionX, y: topMargin)
                let card = CardImageView(origin: origin, width: width)
                cards.append(card)
                positionX += width + sideMargin
            }
            return cards
        }

    }

}
