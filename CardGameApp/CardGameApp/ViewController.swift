//
//  ViewController.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 1. 28..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        guard let image = UIImage(named: "bg_pattern") else { return }
        self.view.backgroundColor = UIColor(patternImage: image)
        
        let numberOfCards = 7
        let bounds = UIScreen.main.bounds
        let ratio = 1.27
        let space = 4
        let totalSpace = (numberOfCards + 1) * space
        let cardWidth = (bounds.width - CGFloat(totalSpace)) / CGFloat(numberOfCards)
        let cardHeight = cardWidth * CGFloat(ratio)
        var cardPointX: CGFloat = CGFloat(space)
        
        for _ in 0..<numberOfCards {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "card_back")
            imageView.frame = .init(x: cardPointX, y: 40, width: cardWidth, height: cardHeight)
            cardPointX += cardWidth + CGFloat(space)
            self.view.addSubview(imageView)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

