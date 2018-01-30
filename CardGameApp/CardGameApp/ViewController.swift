//
//  ViewController.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 1. 26..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var foundationViews: [UIImageView] = []
    private var sevenPileViews: [[UIImageView]] = []
    private var cardDeckView: UIImageView!
    private var openedCardDeckView: UIImageView!
    private var cardWidth: CGFloat!
    private var cardMargin: CGFloat!
    private var cardRatio: CGFloat!
    private var dealerAction: DealerAction!
    private let backImage = UIImage(named: Figure.Image.back.value)
    private let refreshImage = UIImage(named: Figure.Image.refresh.value)

    override func viewDidLoad() {
        super.viewDidLoad()
        setCardGame()
        configureCardGame()
    }

    // shake event
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        super.motionBegan(motion, with: event)
        if motion == .motionShake {
            dealerAction.reset()
            dealerAction.shuffle()
            cardDeckView.image = backImage
            openedCardDeckView.image = nil
            removeSevenPileViews()
            sevenPileViews = []
            spreadSevenPiles()
        }
    }

    private func removeSevenPileViews() {
        sevenPileViews.forEach { pileViews in pileViews.forEach { pileView in pileView.removeFromSuperview() } }
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
            foundationViews.append(getFoundation(index: i))
            self.view.addSubview(foundationViews[i])
        }
    }

    private func getFoundation(index: Int) -> UIImageView {
        let borderLayer = CALayer()
        let borderFrame = getCardLocation(index: index, topMargin: CGFloat(Figure.YPosition.topMargin.value))
        borderLayer.backgroundColor = UIColor.clear.cgColor
        borderLayer.frame = borderFrame
        borderLayer.cornerRadius = CGFloat(Figure.Layer.cornerRadius.value)
        borderLayer.borderWidth = CGFloat(Figure.Layer.borderWidth.value)
        borderLayer.borderColor = UIColor.white.cgColor
        let imageView = UIImageView()
        imageView.layer.addSublayer(borderLayer)
        return imageView
    }

    private func configureCardDeck() {
        cardDeckView = UIImageView(frame: getCardLocation(index: Figure.XPosition.cardDeck.value,
                                                          topMargin: CGFloat(Figure.YPosition.topMargin.value)))
        cardDeckView.contentMode = .scaleAspectFit
        cardDeckView.image = backImage
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(tapCardDeck))
        gesture.numberOfTapsRequired = Figure.Gesture.numberOfTapsRequired.value
        cardDeckView.addGestureRecognizer(gesture)
        cardDeckView.isUserInteractionEnabled = true
        self.view.addSubview(cardDeckView)
    }

    private func configureOpenedCardDeck() {
        openedCardDeckView = UIImageView(frame: getCardLocation(index: Figure.XPosition.openedCardDeck.value,
                                                                topMargin: CGFloat(Figure.YPosition.topMargin.value)))
        openedCardDeckView.contentMode = .scaleAspectFit
        self.view.addSubview(openedCardDeckView)
    }

    @objc private func tapCardDeck() {
        selectOpenedCardDeckViewImage()
        selectCardDeckViewImage()
    }

    private func selectOpenedCardDeckViewImage() {
        guard let card = dealerAction.open() else {
            openedCardDeckView.image = nil
            return
        }
        openedCardDeckView.image = UIImage(named: card.image)
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
            sevenPileViews.append([])
            spreadAPile(xIndex: xIndex)
        }
    }

    private func spreadAPile(xIndex: Int) {
        for yIndex in 0...xIndex {
            sevenPileViews[xIndex].append(getACardImageViewForAPile(xIndex: xIndex, yIndex: yIndex))
            self.view.addSubview(sevenPileViews[xIndex][yIndex])
        }
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
        return imageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

