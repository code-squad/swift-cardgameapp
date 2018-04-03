//
//  ViewController.swift
//  CardGameApp
//
//  Created by yuaming on 02/04/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let cardCount: Int = 7
    private let gap: CGFloat = 2
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCards()
    }
}

// MARK: - Private functions, properties
private extension ViewController {
    func loadCards() {
        for index in 0..<cardCount {
            self.view.addSubview(generateCardView(index))
        }
    }
    
    func generateCardView(_ index: Int) -> CardView {
        let xValue = index == 0 ? 0 : CGFloat(index) * (cardSize.width + gap)
        let point = CGPoint(x: xValue, y: GameView.statusHeight)
        let cardFrame = CGRect(origin: point, size: cardSize)
        return CardView(frame: cardFrame)
    }
    
    var cardSize: CGSize {
        let cardWidth = (self.view.frame.width / CGFloat(cardCount)) - gap
        return CGSize(width: cardWidth, height: cardWidth * 1.27)
    }
}
