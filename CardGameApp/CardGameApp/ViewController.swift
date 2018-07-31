//
//  ViewController.swift
//  CardGameApp
//
//  Created by 김수현 on 2018. 7. 23..
//  Copyright © 2018년 김수현. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var cardDeck: CardDeck!
    private var cardImageView: CardImageView!
    private var cardStack: CardStack!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardDeck = CardDeck()
        cardImageView = CardImageView()
        cardStack = CardStack()
        resetCardGeme()
        makeTapGesture(loadCardDeckImage(cardDeck.getCards()))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func loadBackgroundImage() {
        guard let backgroundImage = UIImage(named: CardName.bgPattern.rawValue) else { return }
        self.view.backgroundColor = UIColor(patternImage: backgroundImage)
    }
    
    private func configureCardStack() {
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
    
    private func makeTapGesture(_ imageView: UIImageView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapCardDeck(_:)))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }
    
    @objc func tapCardDeck(_ sender: UIGestureRecognizer) {
        configurePickCard()
    }
    
    private func configurePickCard() {
        var imageView = UIImageView()
        let position = 5
        let statusBarMargin: CGFloat = 20
        let tapCard = cardDeck.removeOne()
        cardDeck.addPickCard(tapCard)
        imageView = cardImageView.getCardImages(position, tapCard.description, statusBarMargin, .front)
        imageView.accessibilityIdentifier = RemoveIdentifier.pickCardDeck.rawValue
        self.view.addSubview(imageView)
        let cards = cardDeck.getCards()
        if cards.count == 0 {
        self.view.subviews.filter({$0.accessibilityIdentifier == RemoveIdentifier.pickCardDeck.rawValue}).forEach({$0.removeFromSuperview()})
            let pickCards = cardDeck.getPickCard()
            cardDeck.refreshCard(pickCards)
        }
        loadCardDeckImage(cards)
    }
    
    private func loadCardDeckImage(_ cards: [Card]) -> UIImageView {
        var imageView = UIImageView()
        self.view.subviews.filter({$0.accessibilityIdentifier == RemoveIdentifier.openCardDeck.rawValue}).forEach({$0.removeFromSuperview()})
        if cards.isEmpty {
            imageView = loadRefreshImage(cards)
        } else {
            imageView = configureCardDeck(cards)
        }
        return imageView
    }
    
    private func loadRefreshImage(_ cards: [Card]) -> UIImageView {
        var imageView = UIImageView()
        let position = 6
        let statusBarMargin: CGFloat = 20
        imageView = cardImageView.getCardImages(position, CardName.refresh.rawValue, statusBarMargin, .front)
        imageView.accessibilityIdentifier = RemoveIdentifier.refreshCardDeck.rawValue
        self.view.subviews.filter({$0.accessibilityIdentifier == RemoveIdentifier.refreshCardDeck.rawValue}).forEach({$0.removeFromSuperview()})
        makeTapGesture(imageView)
        self.view.addSubview(imageView)
        return imageView
    }
    
    private func configureCardDeck(_ cards: [Card]) -> UIImageView {
        var imageView = UIImageView()
        let position = 6
        let statusBarMargin: CGFloat = 20
        for card in cards {
            imageView = cardImageView.getCardImages(position, card.description, statusBarMargin, .back)
            imageView.accessibilityIdentifier = RemoveIdentifier.openCardDeck.rawValue
            makeTapGesture(imageView)
            self.view.addSubview(imageView)
        }
        return imageView
    }
    
    private func configureEmptyCardStack() {
        let range = 4
        for index in 0..<range {
            self.view.addSubview(cardImageView.getEmptyCardStack(index))
        }
    }
    
    private func resetCardGeme() {
        loadBackgroundImage()
        cardDeck.reset()
        cardDeck.shuffle()
        configureCardStack()
        loadCardDeckImage(cardDeck.getCards())
        configureEmptyCardStack()
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            view.subviews.forEach() {$0.removeFromSuperview()}
            resetCardGeme()
        }
    }

}

