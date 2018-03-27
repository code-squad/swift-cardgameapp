//
//  ViewController.swift
//  CardGameApp
//
//  Created by 권재욱 on 2018. 3. 21..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var cardDeck : BaseControl!
    private var imgFrameMaker : ImgFrameMaker!
    private var foundationView : FoundationView! //UIStackView
    private var cardDeckView : CardDeckView! //UIImageView
    private var openedCard: OpenedCardView! //UIImageView
    private var cardStacksView: CardStacksView! //UIStackView
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgFrameMaker = ImgFrameMaker(UIScreen.main.bounds.width)
        cardDeck.shuffle()
        drawBackGround()
        drawBaseCards()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func drawBaseCards() {
        //FoundationView
        foundationView = FoundationView()
        foundationView.setFoundation(generateFoundations())
        self.view.addSubview(foundationView)
        
        //CardDeckView
        cardDeckView = CardDeckView(frame: imgFrameMaker.generateFrame(Key.Card.lastIndex.count, Key.Card.noStack.count, .top))
        cardDeckView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapCardDeck(sender:))))
        cardDeckView.isUserInteractionEnabled = true
        self.view.addSubview(cardDeckView)
        
        //OpenedCardView
        openedCard = OpenedCardView(frame: imgFrameMaker.generateFrame(Key.Card.opened.count, Key.Card.noStack.count,.top))
        self.view.addSubview(openedCard)
        
        //CardStacksView
        cardStacksView = CardStacksView()
        cardStacksView.setStacks(generateCardStacks())
        self.view.addSubview(cardStacksView)
        
        guard let oneCard = drawCardDeck() else { return }
        drawOpenedCard(oneCard)
    }
    
    @objc private func tapCardDeck(sender : UITapGestureRecognizer) {
        guard let tappedCard = drawCardDeck() else { return }
        drawOpenedCard(tappedCard)
    }
    
    private func drawCardDeck() -> Card? {
        if cardDeck.isEmpty() {
            guard let refreshImg = UIImage(named: Key.Img.refresh.name) else { return nil }
            cardDeckView.image = refreshImg
            return nil
        }
        let oneCard = cardDeck.removeOne()
        cardDeckView.image = oneCard.generateCardImg()
        return oneCard
    }
    
    private func drawOpenedCard(_ oneCard : Card) {
        let movedCard = oneCard.changeSide()
        openedCard.image = movedCard.generateCardImg()
    }
    
    private func generateFoundations() -> [UIImageView] {
        var foundationCards : [UIImageView] = []
        for indexOfOneCard in 0..<Key.Card.foundations.count {
            foundationCards.append(UIImageView(frame: imgFrameMaker.generateFrame(indexOfOneCard,Key.Card.noStack.count, .top)))
        }
        return foundationCards
    }
    
    private func generateCardStacks() -> [[UIImageView]]{
        var cardStacks : [[UIImageView]] = []
        for indexOfOneCard in 0..<Key.Card.baseCards.count {
            cardStacks.append(generateOneCardStack(indexOfOneCard))
        }
        return cardStacks
    }

    private func generateOneCardStack(_ indexOfCard: Int) -> [UIImageView] {
        var oneCardStackView : [UIImageView] = []
        for stackIndex in 0..<indexOfCard {
            let oneCardImgView = UIImageView(frame: imgFrameMaker.generateFrame(indexOfCard,stackIndex,.bottom))
            oneCardImgView.image = cardDeck.removeOne().generateCardImg()
            oneCardStackView.append(oneCardImgView)
        }
        let oneCardImgView = UIImageView(frame: imgFrameMaker.generateFrame(indexOfCard,indexOfCard,.bottom))
        oneCardImgView.image = cardDeck.removeOne().changeSide().generateCardImg()
        oneCardStackView.append(oneCardImgView)
        return oneCardStackView
    }
    
    private func drawBackGround() {
        guard let patternImage = UIImage(named : Key.Img.background.name) else { return }
        self.view.backgroundColor = UIColor.init(patternImage : patternImage)
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        if motion == .motionShake {
            cardDeck.reset()
            cardDeck.shuffle()
            drawBaseCards()
        }
    }

}

