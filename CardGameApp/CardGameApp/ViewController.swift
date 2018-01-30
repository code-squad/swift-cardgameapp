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
        print(UIApplication.shared.statusBarFrame.height)
        viewRespectsSystemMinimumLayoutMargins = false
        view.layoutMargins = UIEdgeInsets(top: UIApplication.shared.statusBarFrame.height,
                                          left: 10,
                                          bottom: 10,
                                          right: 10)
        var cardPosition = CGPoint(x: view.layoutMargins.left, y: view.layoutMargins.top)
        while cardPosition.x+cardSize.width <= view.frame.maxX {
            let cardView = generateCard(cardPosition)
            view.addSubview(cardView)
            cardPosition = CGPoint(x: cardView.frame.origin.x+cardView.frame.width+cardMargins,
                                   y: view.layoutMargins.top)
        }
    }

    var numberOfCards: CGFloat = 7

    var cardMargins: CGFloat {
        return (view.frame.size.width-cardSize.width*numberOfCards)/numberOfCards
    }

    var cardSize: CGSize {
        let width = view.frame.size.width/numberOfCards-15
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
