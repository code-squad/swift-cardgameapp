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
        defaultSetting()
    }
    
    private func defaultSetting() {
        cardDeck.reset()
        cardDeck.shuffle()
        
        backgroundView.setCardStack()
        for count in 1...Unit.cardCountNumber {
            guard let defalutCards = cardDeck.remove(count: count) else { return }
            backgroundView.defaultAddCardStack(with: defalutCards)
        }
        backgroundView.reverseBox(with: cardDeck.list())
        backgroundView.emptyBox()
    }
}
