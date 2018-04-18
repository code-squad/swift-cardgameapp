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
    
    var dragInfo : DragInfo!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardDeck.shuffle()
        drawBackGround()
        drawBaseCards()
        NotificationCenter.default.addObserver(self, selector: #selector(drawOpenedCard(notification:)), name: .didTapCardDeck, object: nil)
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
    }
    
    private func drawBackGround() {
        guard let patternImage = UIImage(named : Key.Img.background.name) else { return }
        self.view.backgroundColor = UIColor.init(patternImage : patternImage)
    }
    
    // TapCard -> drawOpenedCard
    @objc private func tapCardDeck(sender : UITapGestureRecognizer) {
        if cardDeckView.image == UIImage(named: Key.Img.refresh.name) {
            cardDeck.loadOpenedCardDeck()
            self.view.subviews.filter({$0 is OpenedCardView}).forEach({$0.removeFromSuperview()})
            cardDeckView.reset()
            return
        }
        if cardDeck.isEmpty() {
            guard let refreshImg = UIImage(named: Key.Img.refresh.name) else { return }
            cardDeckView.image = refreshImg
            return
        }
        cardDeck.openTopCard()
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
    
    // DoubleTapCard -> (true) move to Foundation or CardStacks
    //               -> (false) not move
    func addDoubleTapGesture(_ imgView: UIImageView){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(doubleTapCard(sender:)))
        gesture.numberOfTapsRequired = 2
        imgView.addGestureRecognizer(gesture)
        imgView.isUserInteractionEnabled = true
    }
    
    @objc private func doubleTapCard(sender: UITapGestureRecognizer) {
        guard let doubleTappedCardView = sender.view as? UIImageView else { return }
        let doubleTappedCardInfo = imgFrameMaker.generateIndex(doubleTappedCardView)
        let moveInfo = cardGameTable.checkMove(doubleTappedCardInfo, gesture: .doubleTap)
        if !moveInfo.isTrue && doubleTappedCardView is OpenedCardView {
            return
        }
        guard moveInfo.isTrue else { return }
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
                guard doubleTappedCardView is OpenedCardView else { return }
                guard let topCard = self.cardDeck.getCardFromOpenedCardDeck() else { return }
                self.cardGameTable.setOpenedCard(topCard)
        })
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
    
    // DragCard
    func addDragGesture(_ imgView: UIImageView) {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(dragCard(sender:)))
        imgView.addGestureRecognizer(gesture)
        imgView.isUserInteractionEnabled = true
    }
    
    @objc private func dragCard(sender : UIPanGestureRecognizer) {
        guard let draggedCardView = sender.view as? UIImageView else { return }
        switch sender.state {
        case .began:
            dragInfo = DragInfo(draggedCardView, originCardInfo: imgFrameMaker.generateIndex(draggedCardView))
            if draggedCardView is OpenedCardView {
                dragInfo.setBelowViews([draggedCardView])
                break
            }
            dragInfo.setBelowViews(cardStacksView.generateCardPack(imgFrameMaker.generateIndex(draggedCardView)))
        case .changed:
            dragInfo.dragChanged(sender)
        case .ended:
            let moveInfo = cardGameTable.checkMove(dragInfo.topCardInfo, gesture: .drag)
            if moveInfo.isTrue {
                let movedCardInfo = cardGameTable.getCardInfo(moveInfo.doubleTappedCard)
                UIView.animate( withDuration: 0.5,
                                animations: {
                                    var count = 0
                                    let baseStackIndex = movedCardInfo.stackIndex
                                    self.dragInfo.cardImgPack.forEach({
                                        $0.layer.zPosition = 1
                                        let oneCardOfPackInfo = CardInfo(movedCardInfo.indexOfCard, baseStackIndex + count, movedCardInfo.position)
                                        $0.frame = self.imgFrameMaker.generateCardViewFrame(oneCardOfPackInfo)
                                        count += 1
                                    })
                                },
                                completion: { _ in
                                    self.foundationView.drawFoundation()
                                    self.cardStacksView.drawStacks()
                                    self.dragInfo.topCardInDraggableViews.removeFromSuperview()
                                    guard self.dragInfo.topCardInDraggableViews is OpenedCardView else { return }
                                    guard let topCard = self.cardDeck.getCardFromOpenedCardDeck() else { return }
                                    self.cardGameTable.setOpenedCard(topCard)
                                }
                )
                return
            }
            UIView.animate(withDuration: 0.5) { self.dragInfo.moveCardBackAgain() }
        default : break
        }
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
// add Views of BaseCards
extension ViewController {
    
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
        openedCardView.layer.zPosition = 1
        addDoubleTapGesture(openedCardView)
        addDragGesture(openedCardView)
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
}

// Generate UIImageViews for Making Base Cards
extension ViewController {
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
            guard !cardStack[stackIndex].isBack() else { oneCardStackView.append(oneCardImgView); continue}
            addDragGesture(oneCardImgView)
            oneCardStackView.append(oneCardImgView)
        }
        let oneFrontCardImgView = UIImageView(frame: imgFrameMaker.generateCardViewFrame(CardInfo(indexOfCard,cardStack.count - 1,.cardStacks)))
        addDoubleTapGesture(oneFrontCardImgView)
        addDragGesture(oneFrontCardImgView)
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
