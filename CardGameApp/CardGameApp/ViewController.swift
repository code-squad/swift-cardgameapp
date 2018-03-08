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
    private var sevenPilesView: SevenPilesView!
    private var sevenPilesVM: SevenPilesViewModel!
    private var cardDeckView: UIImageView!
    private var openedCardDeckView: UIImageView!
    private var openedCardDeckVM: OpenedCardDeckViewModel!
    private var cardWidth: CGFloat!
    private var cardMargin: CGFloat!
    private var cardRatio: CGFloat!
    private var dealerAction: DealerAction!
    private let backImage = UIImage(named: Figure.Image.back.value)
    private let refreshImage = UIImage(named: Figure.Image.refresh.value)

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(pushToFoundations(notification:)),
                                               name: .foundation,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeOpenedCardDeck),
                                               name: .openedCardDeck,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeSevenPiles(notification:)),
                                               name: .sevenPiles,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(doubleTapOnSevenPiles(notification:)),
                                               name: .doubleTapped,
                                               object: nil)
        foundationsView = FoundationsView(frame: CGRect(x: UIScreen.main.bounds.origin.x,
                                                        y: CGFloat(Figure.YPosition.topMargin.value),
                                                        width: UIScreen.main.bounds.width / CGFloat(Figure.Count.cardPiles.value) * CGFloat(Figure.Count.foundations.value),
                                                        height: UIScreen.main.bounds.width / CGFloat(Figure.Count.cardPiles.value) * CGFloat(Figure.Size.ratio.value)))
        foundationsVM = FoundationsViewModel()
        sevenPilesView = SevenPilesView(frame: CGRect(x: UIScreen.main.bounds.origin.x,
                                                      y: CGFloat(Figure.YPosition.cardPileTopMargin.value),
                                                      width: UIScreen.main.bounds.width,
                                                      height: UIScreen.main.bounds.height))
        sevenPilesVM = SevenPilesViewModel()
        openedCardDeckVM = OpenedCardDeckViewModel()
        setCardGame()
        configureCardGame()
    }

    // shake event
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        super.motionBegan(motion, with: event)
        if motion == .motionShake {
            foundationsVM.reset()
            foundationsView.reset()

            openedCardDeckVM.reset()
            dealerAction.reset()
            dealerAction.shuffle()
            cardDeckView.image = backImage

            sevenPilesVM.reset()
            spreadSevenPiles()
        }
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
        view.addSubview(foundationsView)
    }

    @objc private func pushToFoundations(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: [String?]] else { return }
        guard let foundationImages = userInfo[Keyword.foundationImages.value] else { return }
        foundationsView.images = foundationImages
    }

    private func configureCardDeck() {
        cardDeckView = UIImageView(frame: getCardLocation(index: Figure.XPosition.cardDeck.value,
                                                          topMargin: CGFloat(Figure.YPosition.topMargin.value)))
        cardDeckView.contentMode = .scaleAspectFit
        cardDeckView.image = backImage
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapCardDeck))
        tap.numberOfTapsRequired = Figure.TapGesture.once.rawValue
        cardDeckView.addGestureRecognizer(tap)
        cardDeckView.isUserInteractionEnabled = true
        view.addSubview(cardDeckView)
    }

    private func configureOpenedCardDeck() {
        openedCardDeckView = UIImageView(frame: getCardLocation(index: Figure.XPosition.openedCardDeck.value,
                                                                topMargin: CGFloat(Figure.YPosition.topMargin.value)))
        openedCardDeckView.contentMode = .scaleAspectFit
        let doubleTap = UITapGestureRecognizer.init(target: self, action: #selector(doubleTapOpenedCardDeck))
        doubleTap.numberOfTapsRequired = Figure.TapGesture.double.rawValue
        openedCardDeckView.addGestureRecognizer(doubleTap)
        openedCardDeckView.isUserInteractionEnabled = true
        view.addSubview(openedCardDeckView)
    }

    @objc private func changeOpenedCardDeck() {
        guard let cardImage = openedCardDeckVM.lastCardImage else {
            openedCardDeckView.image = nil
            openedCardDeckView.accessibilityIdentifier = ""
            return
        }
        openedCardDeckView.image = UIImage(named: cardImage)
        openedCardDeckView.accessibilityIdentifier = cardImage
    }

    @objc private func tapCardDeck() {
        cardDeckView.isUserInteractionEnabled = false
        selectOpenedCardDeckViewImage()
        selectCardDeckViewImage()
        cardDeckView.isUserInteractionEnabled = true
    }

    @objc private func doubleTapOpenedCardDeck() {
        if let targetPositionOnFoundation = foundationsVM.getTargetPosition(of: openedCardDeckVM.getLastCardInformation()!) {
            animateOpenedCardView(xIndex: targetPositionOnFoundation, yIndex: 0, toFoundation: true)
        } else {
            let targetPositionOnSevenPiles = sevenPilesVM.getTargetPosition(of: openedCardDeckVM.getLastCardInformation()!)
            if let xIndex = targetPositionOnSevenPiles.xIndex, let yIndex = targetPositionOnSevenPiles.yIndex {
                animateOpenedCardView(xIndex: xIndex, yIndex: yIndex, toFoundation: false)
            }
        }
    }

    private func makeCardViewForAnimation(xIndex: Int, topMargin: Int, imageName: String) -> CardView {
        return CardView.makeNewCardView(frame: getCardLocation(index: xIndex,
                                                               topMargin: CGFloat(topMargin)),
                                        imageName: imageName)
    }

    private func willMoveOpenedCard() {
        guard let cardImage = openedCardDeckVM.willMoveImage else {
            openedCardDeckView.image = nil
            return
        }
        openedCardDeckView.image = UIImage(named: cardImage)
    }

    private func animateOpenedCardView(xIndex: Int, yIndex: Int, toFoundation: Bool) {
        view.isUserInteractionEnabled = false
        let newCardView = makeCardViewForAnimation(xIndex: Figure.XPosition.openedCardDeck.value,
                                                   topMargin: Figure.YPosition.topMargin.value,
                                                   imageName: openedCardDeckView.accessibilityIdentifier ?? "")
        view.addSubview(newCardView)
        willMoveOpenedCard()
        let globalPoint = openedCardDeckView.superview?.convert(openedCardDeckView.frame.origin, to: nil)
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 1.0,
            delay: 0.0,
            options: [.curveLinear],
            animations: {
                let dx = (self.cardWidth * CGFloat(xIndex)) + CGFloat(Figure.Size.xGap.value)
                newCardView.frame.origin.x -= (globalPoint?.x)! - dx
                var dy: CGFloat = 0.0
                if toFoundation {
                    dy = CGFloat(Figure.YPosition.topMargin.value)

                } else {
                    dy = CGFloat(Figure.YPosition.cardPileTopMargin.value +
                            (Figure.YPosition.betweenCards.value * yIndex))
                }
                newCardView.frame.origin.y -= (globalPoint?.y)! -  dy
            },
            completion: { _ in
                guard let poppedCard = self.openedCardDeckVM.pop() else { return }
                if toFoundation {
                    guard self.foundationsVM.push(card: poppedCard) else { return }
                } else {
                    guard self.sevenPilesVM.setNewPlace(of: poppedCard) else { return }
                }
                newCardView.removeFromSuperview()
                self.view.isUserInteractionEnabled = true
            }
        )
    }

    private func selectOpenedCardDeckViewImage() {
        guard let card = dealerAction.open() else {
            dealerAction.reLoad(cardPack: openedCardDeckVM.reLoad())
            return
        }
        openedCardDeckVM.push(card: card)
    }

    private func selectCardDeckViewImage() {
        cardDeckView.image = dealerAction.isRemain() ? backImage : refreshImage
    }

    private func spreadSevenPiles() {
        sevenPilesVM.setCardPiles(sevenPiles: dealerAction.getCardPacks(packCount: Figure.Count.cardPiles.value))
        view.addSubview(sevenPilesView)
    }

    @objc private func changeSevenPiles(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: [[String]]] else { return }
        guard let sevenPilesImages = userInfo[Keyword.sevenPilesImages.value] else { return }
        sevenPilesView.images = sevenPilesImages
    }

    @objc private func doubleTapOnSevenPiles(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any] else { return }
        guard let doubleTappedCardView = userInfo[Keyword.doubleTapped.value] as? CardView else { return }
        let imageName = doubleTappedCardView.accessibilityIdentifier ?? ""
        let doubleTappedCardInformation = sevenPilesVM.getDoubleTappedCardInformation(name: imageName)
        if let targetPositionOnFoundation = foundationsVM.getTargetPosition(of: doubleTappedCardInformation.card!) {
            animateCardViewFromSevenPiles(cardView: doubleTappedCardView,
                                          xIndex: targetPositionOnFoundation, yIndex: 0, toFoundation: true)
        } else {
            let targetPositionOnSevenPiles = sevenPilesVM.getTargetPosition(name: imageName)
            if let xIndex = targetPositionOnSevenPiles.xIndex, let yIndex = targetPositionOnSevenPiles.yIndex {
                animateCardViewFromSevenPiles(cardView: doubleTappedCardView,
                                              xIndex: xIndex, yIndex: yIndex, toFoundation: false)
            }
        }
    }

    private func willMoveFromSevenCardPiles(cardView: CardView) {
        cardView.image = nil
        cardView.layer.cornerRadius = CGFloat(Figure.Layer.cornerRadius.value)
    }

    private func animateCardViewFromSevenPiles(cardView: CardView, xIndex: Int, yIndex: Int, toFoundation: Bool) {
        let doubleTappedCardInformation = sevenPilesVM.getDoubleTappedCardInformation(
            name: cardView.accessibilityIdentifier!)
        view.isUserInteractionEnabled = false
        let newCardView = makeCardViewForAnimation(xIndex: doubleTappedCardInformation.position.xIndex!,
                                                   topMargin: Figure.YPosition.cardPileTopMargin.value +
                                                            (Figure.YPosition.betweenCards.value
                                                                * doubleTappedCardInformation.position.yIndex!),
                                                   imageName: cardView.accessibilityIdentifier!)
        view.addSubview(newCardView)
        willMoveFromSevenCardPiles(cardView: cardView)
        let globalPoint = cardView.superview?.convert(cardView.frame.origin, to: nil)
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 1.0,
            delay: 0.0,
            options: [.curveLinear],
            animations: {
                let dx = (self.cardWidth * CGFloat(xIndex)) + CGFloat(Figure.Size.xGap.value)
                var dy: CGFloat = 0.0
                newCardView.frame.origin.x -= (globalPoint?.x)! - dx
                if toFoundation {
                    dy = CGFloat(Figure.YPosition.topMargin.value)
                } else {
                    dy = CGFloat(Figure.YPosition.cardPileTopMargin.value +
                                    (Figure.YPosition.betweenCards.value * yIndex))
                }
                newCardView.frame.origin.y -= (globalPoint?.y)! - dy
            },
            completion: { _ in
                if let poppedCard = self.sevenPilesVM.pop(position: doubleTappedCardInformation.position) {
                    if toFoundation {
                        guard self.foundationsVM.push(card: poppedCard) else { return }
                    } else {
                        guard self.sevenPilesVM.setNewPlace(of: poppedCard) else { return }
                    }
                    newCardView.removeFromSuperview()
                    self.view.isUserInteractionEnabled = true
                }
            }
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
