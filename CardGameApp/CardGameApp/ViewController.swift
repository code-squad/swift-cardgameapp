//
//  ViewController.swift
//  CardGameApp
//
//  Created by 윤동민 on 19/02/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var cardDeck: CardDeck = CardDeck()

    @IBOutlet var spaceViews: [UIView]!
    @IBOutlet weak var cardBack: UIImageView!
    @IBOutlet var pickedCards: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setBackgroundPattern()
        setSpaceView()
        cardBack.image = UIImage(named: "card-back")
        setPickedCardIamge()
    }
    
    private func setBackgroundPattern() {
        self.view.backgroundColor = UIColor.init(patternImage: UIImage(named: "bg_pattern")!)
    }
    
    private func setSpaceView() {
        for view in spaceViews {
            view.backgroundColor = UIColor.clear
            view.layer.borderColor = UIColor.white.cgColor
            view.layer.borderWidth = 1
            view.layer.cornerRadius = 7
            view.clipsToBounds = false
        }
    }
    
    private func setPickedCardIamge() {
        for picked in pickedCards {
            guard let cardImageName = cardDeck.removeOne()?.description else { return }
            picked.image = UIImage(named: cardImageName)
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            cardDeck.reset()
            cardDeck.shuffle()
            setPickedCardIamge()
        }
    }
}

