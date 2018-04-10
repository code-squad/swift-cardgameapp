//
//  ViewController.swift
//  CardGameApp
//
//  Created by 권재욱 on 2018. 3. 21..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Model
    var cardDeck : DeckControl!
    var cardGameTable: TableControl!
    var imgFrameMaker : FrameControl!
    
    //View
    private var foundationView: FoundationView!
    private var cardDeckView: CardDeckView!
    private var openedCardView: OpenedCardView!
    private var cardStacksView: CardStacksView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardDeck.shuffle()
        drawBackGround()
        drawBaseCards()
        NotificationCenter.default.addObserver(self, selector: #selector(drawOpenedCard(notification:)), name: .didTapCardDeck, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(doubleTapCard(notification:)), name: .didDoubleTapCard , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(drawFoundation(notification:)), name: .foundation, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(drawCardStacks(notification:)), name: .cardStacks, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func drawBaseCards() {
        makeCardStacksView()
        makeFoundationView()
        makeCardDeckView()
        makeOpenedCardView()
    }
    
    private func drawBackGround() {
        guard let patternImage = UIImage(named : Key.Img.background.name) else { return }
        self.view.backgroundColor = UIColor.init(patternImage : patternImage)
    }
    
    //Foundation
    fileprivate func makeFoundationView() {
        foundationView = FoundationView()
        foundationView.setFoundation(generateFoundations())
        foundationView.drawFoundation()
        self.view.addSubview(foundationView)
    }
    
    //CardDeck
    fileprivate func makeCardDeckView() {
        cardDeckView = CardDeckView(frame: imgFrameMaker.generateCardViewFrame(CardInfo(Key.Card.lastIndex.count, Key.Card.noStack.count, .top)))
        cardDeckView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapCardDeck(sender:))))
        cardDeckView.isUserInteractionEnabled = true
        self.view.addSubview(cardDeckView)
    }
    //OpenedCard
    fileprivate func makeOpenedCardView() {
        openedCardView = OpenedCardView(frame: imgFrameMaker.generateCardViewFrame(CardInfo(Key.Card.opened.count, Key.Card.noStack.count,.top)))
        addDoubleTapGesture(openedCardView)
        self.view.addSubview(openedCardView)
    }
    
    //CardStacks
    fileprivate func makeCardStacksView() {
        cardStacksView = CardStacksView(frame: imgFrameMaker.generateCardStacksViewFrame())
        var baseCardStacks : [[Card]] = []
        for index in 0..<Key.Card.baseCards.count {
            baseCardStacks.append(cardDeck.generateOneStack(numberOfStack: index))
        }
        cardGameTable.setCardStacks(baseCardStacks)
        cardStacksView.setStacks(generateCardStacks(cardStacks: baseCardStacks))
        cardStacksView.drawStacks()
        self.view.addSubview(cardStacksView)
    }
    
    @objc private func tapCardDeck(sender : UITapGestureRecognizer) {
        if cardDeckView.image == UIImage(named: Key.Img.refresh.name) {
            openedCardView.reset()
            cardDeckView.reset()
            return
        }
        if cardDeck.isEmpty() {
            guard let refreshImg = UIImage(named: Key.Img.refresh.name) else { return}
            cardDeckView.image = refreshImg
            cardDeck.loadOpenedCardDeck()
            return
        }
        cardDeck.openTopCard()
    }
    
    @objc private func drawCardStacks(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: [[Card]]] else { return }
        guard let cardStacks = userInfo[Key.Observer.cardStacks.name] else { return }
        cardStacksView.setStacks(generateCardStacks(cardStacks: cardStacks))
    }
    
    @objc private func drawFoundation(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: [Card]] else { return }
        guard let foundationCards = userInfo[Key.Observer.foundation.name] else { return }
        foundationView.setFoundation(generateFoundations(foundationCards))
    }
    
    @objc private func drawOpenedCard(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String : Card] else { return }
        guard let tappedCard = userInfo[Key.Observer.openedCard.name] else { return }
        var openedCard : Card = tappedCard
        makeOpenedCardView()
        if tappedCard.isBack() {
            openedCard = tappedCard.changeSide()
        }
        openedCardView.image = openedCard.generateCardImg()
        cardGameTable.setOpenedCard(tappedCard)
    }
    
    func addDoubleTapGesture(_ imgView: UIImageView){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(doubleTapCard(sender:)))
        gesture.numberOfTapsRequired = 2
        imgView.addGestureRecognizer(gesture)
        imgView.isUserInteractionEnabled = true
    }
    
    @objc private func doubleTapCard(sender: UITapGestureRecognizer) {
        NotificationCenter.default.post(name: .didDoubleTapCard, object: self, userInfo: [Key.Observer.doubleTapCard.name : sender])
    }
    
    @objc private func doubleTapCard(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let recognizer = userInfo[Key.Observer.doubleTapCard.name] as? UIGestureRecognizer else { return }
        guard let doubleTappedCardView = recognizer.view as? UIImageView else { return }
        let doubleTappedCardInfo = imgFrameMaker.generateIndex(doubleTappedCardView)
        let moveInfo = cardGameTable.moveCard(doubleTappedCardInfo)
        if !moveInfo.isTrue {
            cardDeck.setOpenedCardDeck(moveInfo.doubleTappedCard)
            return
        }
        let movedCardInfo = cardGameTable.getCardInfo(moveInfo.doubleTappedCard)
        UIView.animate(
            withDuration: 0.5,
            animations: {
                doubleTappedCardView.layer.zPosition = 1
                doubleTappedCardView.frame = self.imgFrameMaker.generateCardViewFrame(movedCardInfo)
            },
            completion: { _ in
                self.foundationView.drawFoundation()
                self.cardStacksView.drawStacks()
                doubleTappedCardView.removeFromSuperview()
            })
    }
    
    private func generateFoundations(_ foundations: [Card] = []) -> [UIImageView] {
        var foundationCards : [UIImageView] = []
        var countOfCards : Int {
            if foundations.count > 0 {
                return foundations.count
            }
            return Key.Card.foundations.count
        }
        for indexOfOneCard in 0..<countOfCards{
            let oneFoundation = UIImageView(frame: imgFrameMaker.generateCardViewFrame(CardInfo(indexOfOneCard,Key.Card.noStack.count,.top)))
            if foundations.count > 0 {
                oneFoundation.image = foundations[indexOfOneCard].generateCardImg()
            }
            foundationCards.append(oneFoundation)
        }
        return foundationCards
    }
    
    private func generateCardStacks(cardStacks: [[Card]]) -> [[UIImageView]]{
        var cardStacksView : [[UIImageView]] = []
        for indexOfOneCard in 0..<Key.Card.baseCards.count {
            cardStacksView.append(generateOneCardStack(indexOfOneCard,cardStacks[indexOfOneCard]))
        }
        return cardStacksView
    }
    
    private func generateOneCardStack(_ indexOfCard: Int ,_ cardStack: [Card]) -> [UIImageView] {
        var oneCardStackView : [UIImageView] = []
        var cardStack : [Card] = cardStack
        guard cardStack.count > 0 else { return [] }
        for stackIndex in 0..<cardStack.count - 1 {
            let oneCardImgView = UIImageView(frame: imgFrameMaker.generateCardViewFrame(CardInfo(indexOfCard,stackIndex,.cardStacks)))
            oneCardImgView.image = cardStack[stackIndex].generateCardImg()
            oneCardStackView.append(oneCardImgView)
        }
        let oneFrontCardImgView = UIImageView(frame: imgFrameMaker.generateCardViewFrame(CardInfo(indexOfCard,cardStack.count - 1,.cardStacks)))
        addDoubleTapGesture(oneFrontCardImgView)
        if cardStack[cardStack.count - 1].isBack() {
            oneFrontCardImgView.image = cardStack[cardStack.count - 1].changeSide().generateCardImg()
            oneCardStackView.append(oneFrontCardImgView)
            return oneCardStackView
        }
        oneFrontCardImgView.image = cardStack[cardStack.count - 1].generateCardImg()
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
            cardGameTable = CardGameTable()
            cardDeck.reset()
            cardDeck.shuffle()
            drawBaseCards()
        }
    }
    
}


