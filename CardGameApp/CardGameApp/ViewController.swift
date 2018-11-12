//
//  ViewController.swift
//  CardGameApp
//
//  Created by oingbong on 25/10/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let cardDeck = CardDeck()
    @IBOutlet var backgroundView: BackgroundView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultSetting()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        resetCard()
    }
    
    private func defaultSetting() {
        cardDeck.reset()
        cardDeck.shuffle()
        
        for count in 1...Unit.cardCountNumber {
            guard let defalutCards = cardDeck.remove(count: count) else { return }
            backgroundView.defaultAddCardStack(with: defalutCards)
        }
        backgroundView.reverseBox(with: cardDeck.list())
    }
    
    private func resetCard() {
        backgroundView.resetCard()
        defaultSetting()
    }
}
