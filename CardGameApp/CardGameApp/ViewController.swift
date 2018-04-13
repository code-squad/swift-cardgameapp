//
//  ViewController.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 12..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let widthDivider: CGFloat = 8
    let cardHeightRatio: CGFloat = 1.27
    let blankPositionY: CGFloat = 20
    let cardPositionY: CGFloat = 100

    var cardWidth: CGFloat {
        return self.view.frame.width / widthDivider
    }

    var cardSize: CGSize {
        return CGSize(width: self.cardWidth,
                      height: cardWidth * cardHeightRatio)
    }

    var space: CGFloat {
        return cardWidth / 8
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_pattern")!)
        self.drawCards()
        self.drawStack()
        self.drawFoundations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func drawCards() {
        for i in 0...6 {
            let cardX = (CGFloat(i+1)*space) + (CGFloat(i) * cardWidth)
            let cardImage = CardImageView()
            cardImage.getBackSide()
            cardImage.frame = CGRect(origin: CGPoint(x: cardX, y: cardPositionY),size: self.cardSize)
            print(CGPoint(x: cardX, y: cardPositionY))
            self.view.addSubview(cardImage)
        }
    }

    private func drawFoundations() {
        for i in 0..<4 {
            let cardX = (CGFloat(i+1)*space) + (CGFloat(i) * cardWidth)
            let foundation = UIView(frame: CGRect(origin: CGPoint(x: cardX, y: blankPositionY),
                                             size: self.cardSize))
            foundation.clipsToBounds = true
            foundation.layer.cornerRadius = 5.0
            foundation.layer.borderColor = UIColor.white.cgColor
            foundation.layer.borderWidth = 1.0
            self.view.addSubview(foundation)
        }

    }

    private func drawStack() {
        let upperRightCornerX = 355.78125
        let upperRightCornerY = 20.0
        let stackImage = CardImageView(frame: CGRect(origin: CGPoint(x: upperRightCornerX, y: upperRightCornerY),
                                                     size: self.cardSize))
        stackImage.getBackSide()
        self.view.addSubview(stackImage)
    }

}

