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
    private var cardEvaluator: CardEvaluator!
    //View
    private var foundationView: FoundationView!
    private var cardDeckView: CardDeckView!
    private var openedCardView: OpenedCardView!
    private var cardStacksView: CardStacksView!
    
    //View-Model
    private var foundation: Foundation!
    private var openedCard: OpenedCard!
    private var cardStacks: CardStacks!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgFrameMaker = ImgFrameMaker(UIScreen.main.bounds.width)
        cardDeck.shuffle()
        drawBackGround()
        drawBaseCards()
        NotificationCenter.default.addObserver(self, selector: #selector(drawOpenedCard(notification:)), name: .didTapCardDeck, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(doubleTapCard(notification:)), name: .didDoubleTapCard , object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func drawBaseCards() {
        makeFoundation()
        makeCardDeckView()
        makeOpenedCard()
        makeCardStacks()
    }
    
    private func drawBackGround() {
        guard let patternImage = UIImage(named : Key.Img.background.name) else { return }
        self.view.backgroundColor = UIColor.init(patternImage : patternImage)
    }
    
    //Foundation
    fileprivate func makeFoundation() {
        foundationView = FoundationView()
        let foundationCardImgViews = generateFoundations()
        foundationView.setFoundation(foundationCardImgViews)
        self.view.addSubview(foundationView)
    }
    
    //CardDeck
    fileprivate func makeCardDeckView() {
        cardDeckView = CardDeckView(frame: imgFrameMaker.generateFrame(Key.Card.lastIndex.count, Key.Card.noStack.count, .top))
        cardDeckView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapCardDeck(sender:))))
        cardDeckView.isUserInteractionEnabled = true
        self.view.addSubview(cardDeckView)
    }
    //OpenedCard
    fileprivate func makeOpenedCard() {
        openedCardView = OpenedCardView(frame: imgFrameMaker.generateFrame(Key.Card.opened.count, Key.Card.noStack.count,.top))
        openedCardView.addDoubleTapGesture()
        self.view.addSubview(openedCardView)
    }
    
    //CardStacks
    fileprivate func makeCardStacks() {
        cardStacksView = CardStacksView(frame: imgFrameMaker.generateCardStacksViewFrame())
        let stackImgViews = generateCardStacks()
        cardStacksView.setStacks(stackImgViews)
        self.view.addSubview(cardStacksView)
    }
    
    @objc private func tapCardDeck(sender : UITapGestureRecognizer) {
        if cardDeck.isEmpty() {
            guard let refreshImg = UIImage(named: Key.Img.refresh.name) else { return}
            cardDeckView.image = refreshImg
            return
        }
        cardDeck.removeOne()
    }
    
    @objc func drawOpenedCard(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String : Card] else { return }
        guard let tappedCard = userInfo[Key.Observer.openedCard.name] else { return }
        openedCardView.image = tappedCard.changeSide().generateCardImg()
    }
    
    @objc func doubleTapCard(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String : CGRect] else { return }
        guard let tappedCardFrame = userInfo[Key.Observer.doubleTapCard.name] else { return }
        imgFrameMaker.generateIndex(tappedCardFrame)
    }
    
    private func generateFoundations() -> [UIImageView] {
        var foundationCards : [UIImageView] = []
        for indexOfOneCard in 0..<Key.Card.foundations.count {
            let oneFoundation = UIImageView(frame: imgFrameMaker.generateFrame(indexOfOneCard,Key.Card.noStack.count, .top))
            foundationCards.append(oneFoundation)
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
        var cardStack : [Card] = cardDeck.generateOneStack(numberOfStack: indexOfCard)
        for stackIndex in 0..<indexOfCard {
            let oneCardImgView = UIImageView(frame: imgFrameMaker.generateStackFrame(indexOfCard,stackIndex,.bottom))
            oneCardImgView.image = cardStack[stackIndex].generateCardImg()
            oneCardStackView.append(oneCardImgView)
        }
        let oneFrontCardImgView = UIImageView(frame: imgFrameMaker.generateStackFrame(indexOfCard,indexOfCard,.bottom))
        oneFrontCardImgView.addDoubleTapGesture()
        oneFrontCardImgView.image = cardStack[indexOfCard].changeSide().generateCardImg()
        oneCardStackView.append(oneFrontCardImgView)
        return oneCardStackView
    }
    
}

// Event
extension ViewController {
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        if motion == .motionShake {
            self.view.subviews.forEach { $0.removeFromSuperview() }
            cardDeck.reset()
            cardDeck.shuffle()
            drawBaseCards()
        }
    }
    
}

extension UIImageView {
    
    func addDoubleTapGesture(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(doubleTapCard(sender:)))
        gesture.numberOfTapsRequired = 2
        self.addGestureRecognizer(gesture)
        self.isUserInteractionEnabled = true
    }

    @objc private func doubleTapCard(sender: UITapGestureRecognizer) {
        guard let tappedFrame = sender.view?.frame else { return }
        NotificationCenter.default.post(name: .didDoubleTapCard, object: self, userInfo: [Key.Observer.doubleTapCard.name: tappedFrame])
    }

}


