//
//  ViewController.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 1. 30..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: .init(imageLiteralResourceName: "bg_pattern"))
        viewRespectsSystemMinimumLayoutMargins = false
        view.layoutMargins = UIEdgeInsets(top: UIApplication.shared.statusBarFrame.height,
                                          left: 5,
                                          bottom: 5,
                                          right: 5)
        layCards()
    }

    private func layCards() {
        var cardPosition = CGPoint(x: view.layoutMargins.left, y: view.layoutMargins.top)
        while cardPosition.x+cardSize.width <= view.frame.maxX-view.layoutMargins.right {
            let cardView = generateCard(cardPosition)
            view.addSubview(cardView)
            cardPosition = CGPoint(x: cardView.frame.maxX+cardMargins,
                                   y: view.layoutMargins.top)
        }
    }

    private var numberOfCards: CGFloat = 7

    private var cardMargins: CGFloat {
        let widthWithoutSafeArea = view.frame.size.width-view.layoutMargins.left-view.layoutMargins.right
        return (widthWithoutSafeArea-cardSize.width*numberOfCards)/numberOfCards
    }

    private var cardSize: CGSize {
        let width = view.frame.size.width/numberOfCards-7
        let height = width*1.27
        return CGSize(width: width, height: height)
    }

    private func generateCard(_ origin: CGPoint) -> UIImageView {
        let cardImage = UIImage(imageLiteralResourceName: "card-back")
        let cardImageView = UIImageView(image: cardImage)
        cardImageView.frame.origin = origin
        cardImageView.frame.size = cardSize
        return cardImageView
    }

}
