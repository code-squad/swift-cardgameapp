//
//  ViewController.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 12..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_pattern")!)
        self.drawCards()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func drawCards() {
        let cardWidth = self.view.frame.width / 8
        let cardHeightRatio: CGFloat = 1.27
        let cardY: CGFloat = 50
        let space = cardWidth / 8

        for i in 0...6 {
            let cardX = (CGFloat(i+1)*space) + (CGFloat(i) * cardWidth)

            let cardBackImage = CardImageView().getBackImage()
            cardBackImage.frame = CGRect(x: cardX,
                                         y: cardY,
                                         width: cardWidth,
                                         height: cardWidth * cardHeightRatio)
            self.view.addSubview(cardBackImage)
        }
    }


}

