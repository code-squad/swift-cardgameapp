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
    private var sevenPileViews: [UIImageView] = []
    var cardWidth: CGFloat!
    var cardMargin: CGFloat!
    var cardRatio: CGFloat!
    var dealerAction: DealerAction!

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
            drawSevenPiles()
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
        drawBackground()
        drawFoundations()
        drawCardDeck()
        drawSevenPiles()
    }

    private func drawBackground() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_pattern")!)
    }

    private func getCardLocation(index: Int, topMargin: CGFloat) -> CGRect {
        return CGRect(origin: CGPoint(x: cardWidth * CGFloat(index) + cardMargin, y: topMargin),
                      size: CGSize(width: cardWidth - 1.5 * cardMargin, height: cardWidth * cardRatio))
    }

    private func drawFoundations() {
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

    private func drawCardDeck() {
        let index = 6 // CardDeck을 최우측 상단에 위치시키기 위한 인덱스
        let topMargin = CGFloat(20)
        let imageView = UIImageView(frame: getCardLocation(index: index, topMargin: topMargin))
        let image = UIImage(named: "card-back")
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.view.addSubview(imageView)
    }

    private func drawSevenPiles() {
        for i in 0..<7 {
            sevenPileViews.append(getCardPile(index: i))
            self.view.addSubview(sevenPileViews[i])
        }
    }

    private func getCardPile(index: Int) -> UIImageView {
        let cardPileTopMargin = CGFloat(100)
        let imageView = UIImageView(frame: getCardLocation(index: index, topMargin: cardPileTopMargin))
        let card = dealerAction.removeOne()
        card?.turnUpSideDown()
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

