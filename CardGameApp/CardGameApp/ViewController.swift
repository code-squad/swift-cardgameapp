//
//  ViewController.swift
//  CardGameApp
//
//  Created by 김수현 on 2018. 7. 23..
//  Copyright © 2018년 김수현. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var cardDeck: CardDeck!
    var cardImageView: CardImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImage()
        cardDeck = CardDeck()
        cardImageView = CardImageView()
        cardDeck.shuffle()
        addImageOfCardBack()
        addImageOfCardFront()
        addEmptyCardStack()
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
    
    private func addImageOfCardBack() {
        let range = 6
        self.view.addSubview(cardImageView.getCardImages(range, CardName.cardBack.rawValue, .back))
    }
    
    private func addImageOfCardFront() {
        let range = 7
        for index in 0..<range {
            let cards = cardDeck.removeOne().pick
            self.view.addSubview(cardImageView.getCardImages(index, cards.description, .front))
        }
    }
    
    private func addEmptyCardStack() {
        let range = 4
        for index in 0..<range {
            self.view.addSubview(cardImageView.getEmptyCardStack(index))
        }
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            cardDeck.shuffle()
            addImageOfCardFront()
        }
    }

}

