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
    private var reverseBoxView: ReverseBoxView!
    private var boxView: BoxView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reverseBoxSetting()
        defaultSetting()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        resetCard()
    }
    
    private func reverseBoxSetting() {
        let superWidth = Unit.iphone8plusWidth
        let superSpace = superWidth * Unit.tenPercentOfFrame
        let space = superSpace / Unit.spaceCount
        let width = (superWidth - superSpace) / Unit.cardCount
        let reverseBoxXValue = space * Unit.fromLeftSpaceOfReverseBox + width * Unit.fromLeftWidthOfReverseBox
        let boxXValue = space * Unit.fromLeftSpaceOfBox + width * Unit.fromLeftWidthOfBox
        
        self.reverseBoxView = ReverseBoxView(frame: CGRect(x: reverseBoxXValue, y: Unit.reverseBoxYValue, width: width * Unit.widthRatio, height: width * Unit.heightRatio))
        self.boxView = BoxView(frame: CGRect(x: boxXValue, y: Unit.reverseBoxYValue, width: width * Unit.widthRatio, height: width * Unit.heightRatio))
    }
    
    private func reverseBoxAddSubView(with cardList: [Card]) {
        for card in cardList {
            let rect = CGRect(x: 0, y: 0, width: reverseBoxView.frame.width, height: reverseBoxView.frame.height)
            let cardImageView = CardImageView(card: card, frame: rect)
            reverseBoxView.addSubview(cardImageView)
        }
    }
    
    private func defaultSetting() {
        backgroundView.addSubview(reverseBoxView)
        backgroundView.addSubview(boxView)
        
        cardDeck.reset()
        cardDeck.shuffle()
        
        for count in 1...Unit.cardCountNumber {
            guard let defalutCards = cardDeck.remove(count: count) else { return }
            backgroundView.defaultAddCardStack(with: defalutCards)
        }
        reverseBoxAddSubView(with: cardDeck.list())
    }
    
    private func resetCard() {
        backgroundView.resetCard()
        reverseBoxView.removeSubView()
        boxView.removeSubView()
        defaultSetting()
    }
}
