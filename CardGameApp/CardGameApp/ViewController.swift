//
//  ViewController.swift
//  CardGameApp
//
//  Created by 김수현 on 2018. 7. 23..
//  Copyright © 2018년 김수현. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var imageViews: [UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImage()
        addCardBack()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func addBackgroundImage() {
        guard let backgroundImage = UIImage(named: CardName.bgPattern.rawValue) else { return }
        self.view.backgroundColor = UIColor(patternImage: backgroundImage)
    }
    
    private func addCardBack() {
        let range = 7
        for index in 0..<range {
            self.view.addSubview(CardImageView().getCardBackImages(index))
        }
    }

}

