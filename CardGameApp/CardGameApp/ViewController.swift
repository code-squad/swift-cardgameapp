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
        openedCardDeckVM.push(card: card)
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
        var parentView: UIStackView? = cardStackView.superview as? OpenedCardDeckView
        var doubleTappedCard: Card?
        var isFromOpenedCard: Bool = false
        var isToFoundations: Bool = true
        var originX = 0
        if parentView != nil {
            doubleTappedCard = openedCardDeckVM.getSelectedCard(image: cardView.storedImage)
            isFromOpenedCard = true
        } else {
            parentView = cardStackView.superview as? SevenPilesView
            if parentView != nil {
                doubleTappedCard = sevenPilesVM.getSelectedCard(image: cardView.storedImage)
                originX = self.sevenPilesVM.getSelectedCardPosition(of: doubleTappedCard!).xIndex!
            }
        }
        guard doubleTappedCard != nil else { return }
        var availablePosition = foundationsVM.availablePosition(of: doubleTappedCard!)
        if availablePosition.xIndex == nil {
            availablePosition = sevenPilesVM.availablePosition(of: doubleTappedCard!)
            isToFoundations = false
        }
        guard availablePosition.xIndex != nil else { return }
        view.isUserInteractionEnabled = false
        let globalPoint = cardView.superview?.convert(cardView.frame.origin, to: nil)
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 1.0,
            delay: 0.0,
            options: [.curveLinear],
            animations: { [weak self] in
                self?.view.bringSubview(toFront: parentView!)
                parentView?.bringSubview(toFront: cardStackView)
                let dx = ((self?.cardWidth)! * CGFloat(availablePosition.xIndex!)) + CGFloat(Figure.Size.xGap.value)
                cardView.frame.origin.x -= (globalPoint?.x)! - dx
                var dy: CGFloat = CGFloat(Figure.YPosition.topMargin.value)
                if !isToFoundations {
                    dy = CGFloat(Figure.YPosition.cardPileTopMargin.value +
                        (Figure.YPosition.betweenCards.value * (availablePosition.yIndex!)))
                }
                cardView.frame.origin.y -= (globalPoint?.y)! - dy
            },
            completion: { [weak self] _ in
                parentView?.insertSubview(cardStackView, at: originX)
                switch (isFromOpenedCard, isToFoundations) {
                case (true, true):
                    self?.foundationsVM.push(card: (self?.openedCardDeckVM.pop()!)!)
                case (false, true):
                    self?.foundationsVM.push(card: (self?.sevenPilesVM.pop(index: originX)!)!)
                case (true, false):
                    self?.sevenPilesVM.push(card: (self?.openedCardDeckVM.pop()!)!)
                case (false, false):
                    self?.sevenPilesVM.push(card: (self?.sevenPilesVM.pop(index: originX)!)!)
                }
                self?.view.isUserInteractionEnabled = true
            }
        )
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
