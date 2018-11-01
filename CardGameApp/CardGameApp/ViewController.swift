//
//  ViewController.swift
//  CardGameApp
//
//  Created by oingbong on 25/10/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let cardCount = 7
    private let cardDeck = CardDeck()
    @IBOutlet var patternUIView: PatternUIView!
    
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
        
        patternUIView.setCardStack()
        for count in 1...cardCount {
            guard let defalutCards = cardDeck.remove(count: count) else { return }
            patternUIView.defaultAddCardStack(with: defalutCards)
        }
        patternUIView.reverseBox(with: cardDeck.list())
        patternUIView.emptyBox()
    }
}
