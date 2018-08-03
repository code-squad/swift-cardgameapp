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
    
    private var stackImageView: UIImageView!
    private var deckImageView: UIImageView!
    private var pickImageView: UIImageView!
    
    private var pickImageViews = [UIImageView]()
    private var deckImageViews = [UIImageView]()
    private var refreshImages = [UIImageView]()
    
    
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
        var statusBarMargin: CGFloat = 100
        for i in 0..<stack.count {
            for j in i..<stack.count {
                if i == j {
                    stackImageView = cardImageView.getCardImages(j, stack[j][i].description, statusBarMargin, .front)
                    self.view.addSubview(stackImageView)
                } else {
                    stackImageView = cardImageView.getCardImages(j, stack[j][i].description, statusBarMargin, .back)
                    self.view.addSubview(stackImageView)
                }
            }
            statusBarMargin += 20
        }
    }
    
    private func makeTapGesture(_ imageView: UIImageView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapCardDeck(_:)))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }
    
    @objc func tapCardDeck(_ sender: UIGestureRecognizer) {
        loadPickCardImage()
    }
    
    private func loadPickCardImage() {
        let position = 5
        let statusBarMargin: CGFloat = 20
        let tapCard = cardDeck.removeOne()
        
        cardDeck.addPickCard(tapCard)
        pickImageView = cardImageView.getCardImages(position, tapCard.description, statusBarMargin, .front)
        pickImageViews.append(pickImageView)
        self.view.addSubview(pickImageView)
        configurePickCard()
    }
    
    private func configurePickCard() {
        let cards = cardDeck.getCards()
        if cards.count == 0 {
            pickImageViews.forEach({$0.removeFromSuperview()})
            let pickCards = cardDeck.getPickCard()
            cardDeck.refreshCard(pickCards)
        }
        loadCardDeckImage(cards)
    }
    
    private func loadCardDeckImage(_ cards: [Card]) -> UIImageView {
        deckImageViews.forEach({$0.removeFromSuperview()})
        if cards.isEmpty {
            deckImageView = loadRefreshImage(cards)
        } else {
            deckImageView = configureCardDeck(cards)
        }
        return deckImageView
    }
    
    private func loadRefreshImage(_ cards: [Card]) -> UIImageView {
        let position = 6
        let statusBarMargin: CGFloat = 20
        deckImageView = cardImageView.getCardImages(position, CardName.refresh.rawValue, statusBarMargin, .front)
        refreshImages.append(deckImageView)
        refreshImages.forEach({$0.removeFromSuperview()})
        makeTapGesture(deckImageView)
        self.view.addSubview(deckImageView)
        return deckImageView
    }
    
    private func configureCardDeck(_ cards: [Card]) -> UIImageView {
        let position = 6
        let statusBarMargin: CGFloat = 20
        for card in cards {
            deckImageView = cardImageView.getCardImages(position, card.description, statusBarMargin, .back)
            deckImageViews.append(deckImageView)
            makeTapGesture(deckImageView)
            self.view.addSubview(deckImageView)
        }
        return deckImageView
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

