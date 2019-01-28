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
        let cardWidth: CGFloat = (bounds.width - totalSpace.cgFloat()) / numberOfCards.cgFloat()
        let cardHeight: CGFloat = cardWidth * ratio.cgFloat()
        var cardPointX: CGFloat = space.cgFloat()
        let cardPointY: CGFloat = 40
        
        for _ in 0..<numberOfCards {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "card_back")
            imageView.frame = .init(x: cardPointX, y: cardPointY, width: cardWidth, height: cardHeight)
            cardPointX += cardWidth + space.cgFloat()
            self.view.addSubview(imageView)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension Int {
    func cgFloat() -> CGFloat {
        return CGFloat(self)
    }
}

extension Double {
    func cgFloat() -> CGFloat {
        return CGFloat(self)
    }
}
