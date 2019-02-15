//
//  ViewController.swift
//  CardGameApp
//
//  Created by 윤동민 on 15/02/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var cards: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initialBackground()
        initialCards()
    }
    
    private func initialBackground() {
        self.view.backgroundColor = UIColor.init(patternImage: UIImage(named: "bg_pattern")!)
    }
    
    private func initialCards() {
        for card in cards { card.image = UIImage(named: "card-back") }
    }
}

