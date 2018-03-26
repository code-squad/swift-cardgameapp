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
    private var imgViewMaker : ImageViewMaker!
    private var cardDeckView : UIImageView!
    private var openedCard: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgViewMaker = ImageViewMaker(UIScreen.main.bounds.width)
        cardDeck.shuffle()
        setBackGround()
        setBaseCardImgViews()
        drawCardStacks()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setBaseCardImgViews() {
        //FoundationView
        for indexOfOneCard in 0..<Key.Card.foundations.count {
            self.view.addSubview(imgViewMaker.generateCardImgView(indexOfOneCard,Key.Card.noStack.count,.top, UIImage(), true))
        }
        //CardDeckView
        let oneCard = cardDeck.removeOne()
        cardDeckView = imgViewMaker.generateCardImgView(Key.Card.lastIndex.count,Key.Card.noStack.count,.top, oneCard.generateCardImg(), false)
        self.view.addSubview(cardDeckView)
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(tapCardDeck(sender:)))
        gesture.numberOfTapsRequired = 2
        cardDeckView.addGestureRecognizer(gesture)
        cardDeckView.isUserInteractionEnabled = true
        //OpenedCardView
        openedCard = imgViewMaker.generateCardImgView(Key.Card.opened.count, Key.Card.noStack.count, .top, UIImage(), false)
        self.view.addSubview(openedCard)
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
    
    private func drawCardStacks() {
        for indexOfOneCard in 0..<Key.Card.baseCards.count {
            drawOneCardStack(indexOfOneCard)
        }
    }
    
    private func drawOneCardStack(_ indexOfCard: Int) {
        var cardImg : UIImage!
        for stackIndex in 0..<indexOfCard {
            cardImg = cardDeck.removeOne().generateCardImg()
            self.view.addSubview(imgViewMaker.generateCardImgView(indexOfCard,stackIndex,.bottom,cardImg,false))
        }
        cardImg = cardDeck.removeOne().changeSide().generateCardImg()
        self.view.addSubview(imgViewMaker.generateCardImgView(indexOfCard,indexOfCard,.bottom,cardImg,false))
    }
    
    private func setBackGround() {
        guard let patternImage = UIImage(named : Key.Img.background.name) else { return }
        self.view.backgroundColor = UIColor.init(patternImage : patternImage)
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        if motion == .motionShake {
            cardDeck.reset()
            cardDeck.shuffle()
            setBaseCardImgViews()
            drawCardStacks()
        }
    }

}

