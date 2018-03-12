//
//  ViewController.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 1. 26..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var foundationsView: FoundationsView!
    private var foundationsVM: FoundationsViewModel!
    private var openedCardDeckView: OpenedCardDeckView!
    private var cardDeckView: CardDeckView!
    private var openedCardDeckVM: OpenedCardDeckViewModel!
    private var sevenPilesView: SevenPilesView!
    private var sevenPilesVM: SevenPilesViewModel!

    private var cardWidth: CGFloat!
    private var cardMargin: CGFloat!
    private var cardRatio: CGFloat!

    private var dealerAction: DealerAction!

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(pushToFoundations(notification:)),
                                               name: .foundation,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeOpenedCardDeck(notification:)),
                                               name: .openedCardDeck,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeSevenPiles(notification:)),
                                               name: .sevenPiles,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(tappedCardDeck(notification:)),
                                               name: .tappedCardDeck,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(doubleTapped(notification:)),
                                               name: .doubleTapped,
                                               object: nil)
        setCardGame()
        configureCardGame()
    }

    // set card game
    private func setCardGame() {
        setCardSize()
        setCardDeck()
    }

    private func setCardSize() {
        cardWidth = UIScreen.main.bounds.width / CGFloat(Figure.Size.countInRow.value)
        cardMargin = cardWidth / CGFloat(Figure.Size.yGap.value)
        cardRatio = CGFloat(Figure.Size.ratio.value)
    }

    private func setCardDeck() {
        dealerAction = DealerAction()
        dealerAction.shuffle()
    }

    // draw card game
    private func configureCardGame() {
        configureBackground()
        configureFoundations()
        configureOpenedCardDeck()
        configureCardDeck()
        spreadSevenPiles()
    }

    private func configureBackground() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: Figure.Image.background.value)!)
    }

    private func getCardLocation(index: Int, topMargin: CGFloat) -> CGRect {
        return CGRect(origin: CGPoint(x: cardWidth * CGFloat(index) + cardMargin,
                                      y: topMargin),
                      size: CGSize(width: cardWidth - CGFloat(Figure.Size.xGap.value) * cardMargin,
                                   height: cardWidth * cardRatio))
    }

    private func configureFoundations() {
        let foundationsViewWidth = UIScreen.main.bounds.width
                                    / CGFloat(Figure.Count.cardPiles.value)
                                    * CGFloat(Figure.Count.foundations.value)
        let foundationsViewHeight = UIScreen.main.bounds.width
                                    / CGFloat(Figure.Count.cardPiles.value)
                                    * CGFloat(Figure.Size.ratio.value)
        foundationsView = FoundationsView(frame: CGRect(x: UIScreen.main.bounds.origin.x,
                                                        y: CGFloat(Figure.YPosition.topMargin.value),
                                                        width: foundationsViewWidth,
                                                        height: foundationsViewHeight))
        foundationsVM = FoundationsViewModel()
        view.addSubview(foundationsView)
    }

    private func configureCardDeck() {
        let cardDeckFrame = getCardLocation(index: Figure.XPosition.cardDeck.value,
                                            topMargin: CGFloat(Figure.YPosition.topMargin.value))
        cardDeckView = CardDeckView(frame: cardDeckFrame)
        view.addSubview(cardDeckView)
    }

    private func configureOpenedCardDeck() {
        let openedCardDeckFrame = getCardLocation(index: Figure.XPosition.openedCardDeck.value,
                                                  topMargin: CGFloat(Figure.YPosition.topMargin.value))
        openedCardDeckView = OpenedCardDeckView(frame: openedCardDeckFrame)
        openedCardDeckVM = OpenedCardDeckViewModel()
        view.addSubview(openedCardDeckView)
    }

    private func spreadSevenPiles() {
        sevenPilesView = SevenPilesView(frame: CGRect(x: UIScreen.main.bounds.origin.x,
                                                      y: CGFloat(Figure.YPosition.cardPileTopMargin.value),
                                                      width: UIScreen.main.bounds.width,
                                                      height: UIScreen.main.bounds.height))
        sevenPilesVM = SevenPilesViewModel()
        sevenPilesVM.spreadCardPiles(sevenPiles: dealerAction.getCardPacks(packCount: Figure.Count.cardPiles.value))
        view.addSubview(sevenPilesView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: View ReDraw
extension ViewController {
    @objc private func pushToFoundations(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: [CardImages]] else { return }
        guard let foundationImages = userInfo[Keyword.foundationImages.value] else { return }
        foundationsView.imagesPack = foundationImages
    }

    @objc private func changeOpenedCardDeck(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: CardImages] else { return }
        guard let openedCardDeckImages = userInfo[Keyword.openedCardImages.value] else { return }
        openedCardDeckView.cardImages = openedCardDeckImages
    }

    @objc private func changeSevenPiles(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: [CardImages]] else { return }
        guard let sevenPilesImages = userInfo[Keyword.sevenPilesImages.value] else { return }
        sevenPilesView.imagesPack = sevenPilesImages
    }
}

// MARK: Tab Gesture
extension ViewController {
    @objc func tappedCardDeck(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any] else { return }
        if (userInfo[Keyword.tappedCardDeck.value] as? CardDeckView) != nil {
            view.isUserInteractionEnabled = false
            selectOpenedCardDeckViewImage()
            selectCardDeckViewImage()
            view.isUserInteractionEnabled = true
        }
    }

    private func selectOpenedCardDeckViewImage() {
        guard let card = dealerAction.open() else {
            dealerAction.reLoad(cardPack: openedCardDeckVM.reLoad())
            return
        }
        _ = openedCardDeckVM.push(card: card)
    }

    private func selectCardDeckViewImage() {
        cardDeckView.image = dealerAction.isRemain() ? cardDeckView.backImage : cardDeckView.refreshImage
    }
}

// MARK: Double Tap Gesture
extension ViewController {

    @objc private func doubleTapped(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any] else { return }
        guard let cardView = userInfo[Keyword.doubleTapped.value] as? CardView else { return }
        guard let cardStackView = cardView.superview as? CardStackView else { return }
        guard cardView == cardStackView.subviews[cardStackView.subviews.count-1] else { return }
        guard let parentView = cardStackView.superview else { return }
        guard let originInformation = originInformation(cardView: cardView) else { return }
        let cardInformation = originInformation.from
        let isFromOpenedCard = originInformation.isFromOpenedCard
        guard let targetInformation = targetInformation(card: cardInformation.card) else { return }
        let target = targetInformation.target
        let isToFoundations = targetInformation.isToFoundations
        view.isUserInteractionEnabled = false
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 1.0,
            delay: 0.0,
            options: [.curveLinear],
            animations: { [weak self = self] in
                self?.view.bringSubview(toFront: parentView)
                parentView.bringSubview(toFront: cardStackView)
                self?.moveCardView(cardView: cardView, to: target, isToFoundations: isToFoundations)
            },
            completion: { [weak self = self] _ in
                parentView.insertSubview(cardStackView, at: cardInformation.indexes.xIndex)
                self?.moveCardModel(cardIndexes: cardInformation.indexes,
                                   isFromOpenedCard: isFromOpenedCard,
                                   isToFoundations: isToFoundations)
                self?.view.isUserInteractionEnabled = true
            }
        )
    }

    private func originInformation(cardView: CardView) -> (from: CardInformation, isFromOpenedCard: Bool)? {
        guard let cardStackView = cardView.superview as? CardStackView else { return nil }
        guard cardView == cardStackView.subviews[cardStackView.subviews.count-1] else { return nil }
        if (cardStackView.superview as? OpenedCardDeckView) != nil {
            guard let cardInformation = openedCardDeckVM.getSelectedCardInformation(image: cardView.storedImage)
                else { return nil }
            return (from: cardInformation, isFromOpenedCard: true)
        } else if (cardStackView.superview as? SevenPilesView) != nil {
            guard let cardInformation = sevenPilesVM.getSelectedCardInformation(image: cardView.storedImage)
                else { return nil }
            return (from: cardInformation, isFromOpenedCard: false)
        } else {
            return nil
        }
    }

    private func targetInformation(card: Card) -> (target: CardIndexes, isToFoundations: Bool)? {
        if let availablePosition = foundationsVM.availablePosition(of: card) {
            return (target: availablePosition, isToFoundations: true)
        } else if let availablePosition = sevenPilesVM.availablePosition(of: card) {
            return (target: availablePosition, isToFoundations: false)
        } else {
            return nil
        }
    }

    private func moveCardView(cardView: CardView, to target: CardIndexes, isToFoundations: Bool) {
        let globalPoint = cardView.superview?.convert(cardView.frame.origin, to: nil)
        let dx = (cardWidth * CGFloat(target.xIndex)) + CGFloat(Figure.Size.xGap.value)
        cardView.frame.origin.x -= (globalPoint?.x)! - dx
        var dy = CGFloat(Figure.YPosition.topMargin.value)
        if !isToFoundations {
            dy = CGFloat(Figure.YPosition.cardPileTopMargin.value +
                (Figure.YPosition.betweenCards.value * target.yIndex))
        }
        cardView.frame.origin.y -= (globalPoint?.y)! - dy
    }

    private func moveCardModel(cardIndexes: CardIndexes, isFromOpenedCard: Bool, isToFoundations: Bool) {
        switch (isFromOpenedCard, isToFoundations) {
        case (true, true):
            _ = foundationsVM.push(card: openedCardDeckVM.pop()!)
        case (false, true):
            _ = foundationsVM.push(card: sevenPilesVM.pop(index: cardIndexes.xIndex)!)
        case (true, false):
            _ = sevenPilesVM.push(card: openedCardDeckVM.pop()!)
        case (false, false):
            _ = sevenPilesVM.push(card: sevenPilesVM.pop(index: cardIndexes.xIndex)!)
        }
    }

}

// MARK: Shake event
extension ViewController {

    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        super.motionBegan(motion, with: event)
        if motion == .motionShake {
            foundationsVM.reset()
            foundationsView.reset()

            openedCardDeckVM.reset()
            dealerAction.reset()
            dealerAction.shuffle()
            cardDeckView.image = cardDeckView.backImage

            sevenPilesVM.reset()
            spreadSevenPiles()
        }
    }

}
