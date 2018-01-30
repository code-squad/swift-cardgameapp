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
    private let backImage = UIImage(named: "card-back")
    private let refreshImage = UIImage(named: "cardgameapp-refresh-app")

    override func viewDidLoad() {
        super.viewDidLoad()
        setCardGame()
        drawCardGame()
    }

    // shake event
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        super.motionBegan(motion, with: event)
        if motion == .motionShake {
            dealerAction.reset()
            dealerAction.shuffle()
            spreadSevenPiles()
        }
    }

    // set card game
    private func setCardGame() {
        setCardSize()
        setCardDeck()
    }

    private func setCardSize() {
        cardWidth = UIScreen.main.bounds.width / 7
        cardMargin = cardWidth / 30
        cardRatio = CGFloat(1.27)
    }

    private func setCardDeck() {
        dealerAction = DealerAction()
        dealerAction.shuffle()
    }

    // draw card game
    private func drawCardGame() {
        configureBackground()
        configureFoundations()
        configureOpenedCardDeck()
        configureCardDeck()
        spreadSevenPiles()
    }

    private func configureBackground() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_pattern")!)
    }

    private func getCardLocation(index: Int, topMargin: CGFloat) -> CGRect {
        return CGRect(origin: CGPoint(x: cardWidth * CGFloat(index) + cardMargin, y: topMargin),
                      size: CGSize(width: cardWidth - 1.5 * cardMargin, height: cardWidth * cardRatio))
    }

    private func configureFoundations() {
        for i in 0..<4 {
            foundationViews.append(getFoundation(index: i))
            self.view.addSubview(foundationViews[i])
        }
    }

    private func getFoundation(index: Int) -> UIImageView {
        let topMargin = CGFloat(20)
        let borderLayer = CALayer()
        let borderFrame = getCardLocation(index: index, topMargin: topMargin)
        borderLayer.backgroundColor = UIColor.clear.cgColor
        borderLayer.frame = borderFrame
        borderLayer.cornerRadius = 5.0
        borderLayer.borderWidth = 1.0
        borderLayer.borderColor = UIColor.white.cgColor
        let imageView = UIImageView()
        imageView.layer.addSublayer(borderLayer)
        return imageView
    }

    private func configureCardDeck() {
        let index = 6 // CardDeck을 최우측 상단에 위치시키기 위한 인덱스
        let topMargin = CGFloat(20)
        cardDeckView = UIImageView(frame: getCardLocation(index: index, topMargin: topMargin))
        cardDeckView.contentMode = .scaleAspectFit
        cardDeckView.image = backImage
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(tapCardDeck))
        gesture.numberOfTapsRequired = 1
        cardDeckView.addGestureRecognizer(gesture)
        cardDeckView.isUserInteractionEnabled = true
        self.view.addSubview(cardDeckView)
    }

    private func configureOpenedCardDeck() {
        let index = 5
        let topMargin = CGFloat(20)
        openedCardDeckView = UIImageView(frame: getCardLocation(index: index, topMargin: topMargin))
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
        for xIndex in 0..<7 {
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
        let cardPileTopMargin = CGFloat(100) + (CGFloat(15) * CGFloat(yIndex))
        let imageView = UIImageView(frame: getCardLocation(index: xIndex, topMargin: cardPileTopMargin))
        let card = dealerAction.removeOne()
        if xIndex == yIndex {
            card?.turnUpSideDown()
        }
        let image = UIImage(named: card?.image ?? "card-back")
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        return imageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

