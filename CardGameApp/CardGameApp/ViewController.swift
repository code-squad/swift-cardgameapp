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
        foundationsView = FoundationsView()
        foundationsVM = FoundationsViewModel()
        sevenPilesView = SevenPilesView()
        sevenPilesVM = SevenPilesViewModel()
        openedCardDeckVM = OpenedCardDeckViewModel()
        setCardGame()
        configureCardGame()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeFoundation(notification:)),
                                               name: .foundation,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeOpenedCardDeck),
                                               name: .openedCardDeck,
                                               object: nil)
    }

    // shake event
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        super.motionBegan(motion, with: event)
        if motion == .motionShake {
            dealerAction.reset()
            dealerAction.shuffle()
            cardDeckView.image = backImage
            openedCardDeckView.image = nil
//            removeSevenPileViews()
//            sevenPilesView = []
            spreadSevenPiles()
        }
    }

//    private func removeSevenPileViews() {
//        sevenPilesView.forEach { pileViews in pileViews.forEach { pileView in pileView.removeFromSuperview() } }
//    }

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
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: Figure.Image.background.value)!)
    }

    private func getCardLocation(index: Int, topMargin: CGFloat) -> CGRect {
        return CGRect(origin: CGPoint(x: cardWidth * CGFloat(index) + cardMargin,
                                      y: topMargin),
                      size: CGSize(width: cardWidth - CGFloat(Figure.Size.xGap.value) * cardMargin,
                                   height: cardWidth * cardRatio))
    }

    private func configureFoundations() {
        for i in 0..<Figure.Count.foundations.value {
            foundationsView.addSubview(getFoundation(index: i))
        }
        self.view.addSubview(foundationsView)
    }

    private func getFoundation(index: Int) -> UIImageView {
        let borderFrame = getCardLocation(index: index, topMargin: CGFloat(Figure.YPosition.topMargin.value))
        let imageView = UIImageView(frame: borderFrame)
        imageView.layer.cornerRadius = CGFloat(Figure.Layer.cornerRadius.value)
        imageView.layer.borderWidth = CGFloat(Figure.Layer.borderWidth.value)
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }

    @objc private func changeFoundation(notification: Notification) {
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
        self.view.addSubview(cardDeckView)
    }

    private func configureOpenedCardDeck() {
        openedCardDeckView = UIImageView(frame: getCardLocation(index: Figure.XPosition.openedCardDeck.value,
                                                                topMargin: CGFloat(Figure.YPosition.topMargin.value)))
        openedCardDeckView.contentMode = .scaleAspectFit
        let doubleTap = UITapGestureRecognizer.init(target: self, action: #selector(doubleTapOpenedCardDeck))
        doubleTap.numberOfTapsRequired = Figure.TapGesture.double.rawValue
        openedCardDeckView.addGestureRecognizer(doubleTap)
        openedCardDeckView.isUserInteractionEnabled = true

        self.view.addSubview(openedCardDeckView)
    }

    @objc private func changeOpenedCardDeck() {
        guard let cardImage = openedCardDeckVM.lastCardImage else {
            openedCardDeckView.image = nil
            return
        }
        openedCardDeckView.image = UIImage(named: cardImage)
    }

    @objc private func tapCardDeck() {
        selectOpenedCardDeckViewImage()
        selectCardDeckViewImage()
    }

    @objc private func doubleTapOpenedCardDeck() {
        guard let card = openedCardDeckVM.pop() else { return }
        guard foundationsVM.push(card: card) else {
            let _ = openedCardDeckVM.push(card: card)
            print("fail")
            return
        }
        print("success")
    }

    private func selectOpenedCardDeckViewImage() {
        guard let card = dealerAction.open() else {
            dealerAction.reLoad(cardPack: openedCardDeckVM.reLoad())
            return
        }
        openedCardDeckVM.push(card: card)
    }

    private func selectCardDeckViewImage() {
        guard dealerAction.isRemain() else {
            cardDeckView.image = refreshImage
            return
        }
        cardDeckView.image = backImage
    }

    private func spreadSevenPiles() {
        for xIndex in 0..<Figure.Count.cardPiles.value {

//            sevenPilesView.append([])
            spreadAPile(xIndex: xIndex)
        }
    }

    private func spreadAPile(xIndex: Int) {
        for yIndex in 0...xIndex {
            sevenPilesView.addSubview(getACardImageViewForAPile(xIndex: xIndex, yIndex: yIndex))
//            sevenPileViews[xIndex].append(getACardImageViewForAPile(xIndex: xIndex, yIndex: yIndex))
//            self.view.addSubview(sevenPileViews[xIndex][yIndex])
        }
        self.view.addSubview(sevenPilesView)
    }

    private func getACardImageViewForAPile(xIndex: Int, yIndex: Int) -> UIImageView {
        let cardPileTopMargin = CGFloat(Figure.YPosition.cardPileTopMargin.value)
                                + (CGFloat(Figure.YPosition.betweenCards.value) * CGFloat(yIndex))
        let imageView = UIImageView(frame: getCardLocation(index: xIndex, topMargin: cardPileTopMargin))
        let card = dealerAction.removeOne()
        if xIndex == yIndex {
            card?.turnUpSideDown()
        }
        let image = UIImage(named: card?.image ?? Figure.Image.back.value)
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        sevenPilesVM.setCardPiles(card: card!, xIndex: xIndex)
        return imageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

