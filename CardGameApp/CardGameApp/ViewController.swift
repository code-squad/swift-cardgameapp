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
    var cardStack: CardStack!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImage()
        cardDeck = CardDeck()
        cardImageView = CardImageView()
        cardStack = CardStack()
        cardDeck.shuffle()
        addImageOfCardStack()
        addImageOfCardBack()
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
    
    private func addImageOfCardStack() {
        let stack = cardStack.makeCardStack(cardDeck)
        var index = 7
        var position = 0
        var statusBarMargin: CGFloat = 100
        for i in 0..<stack.count {
            for j in 0..<index {
                if j == 0 {
                    self.view.addSubview(cardImageView.getCardImages(position, stack[i][j].description, statusBarMargin, .front))
                } else {
                    self.view.addSubview(cardImageView.getCardImages(position, stack[i][j].description, statusBarMargin, .back))
                }
                position += 1
            }
            position = 1
            position += i
            index -= 1
            statusBarMargin += 20
        }
    }
    
    private func addImageOfCardBack() {
        let range = 6
        self.view.addSubview(cardImageView.getCardImages(range, CardName.cardBack.rawValue, 20, .back))
    }
    
    private func addEmptyCardStack() {
        let range = 4
        for index in 0..<range {
            self.view.addSubview(cardImageView.getEmptyCardStack(index))
        }
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            view.subviews.forEach() {$0.removeFromSuperview()}
            cardDeck.reset()
            cardDeck.shuffle()
            addImageOfCardStack()
            addImageOfCardBack()
            addEmptyCardStack()
        }
    }

}

