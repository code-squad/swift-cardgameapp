//
//  ViewController.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 1. 26..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var imageViews: [UIImageView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        drawBackground()
        drawCardDummys()
    }

    private func drawBackground() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_pattern.png")!)
    }

    private func drawCardDummys() {
        for i in 0..<7 {
            imageViews.append(getCardDummy(index: i))
            self.view.addSubview(imageViews[i])
        }
    }

    private func getCardDummy(index: Int) -> UIImageView {
        let width = UIScreen.main.bounds.width / 7
        let margin = width / 30
        let ratio = CGFloat(1.27)
        let statusBarMargin = CGFloat(20)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: width * CGFloat(index) + margin,
                                                                  y: statusBarMargin),
                                                  size: CGSize(width: width - 1.5 * margin,
                                                               height: width * ratio)))
        let image = UIImage(named: "card-back")
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        return imageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

