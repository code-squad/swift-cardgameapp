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
    private var cardDeckView: UIImageView!
    private var sevenPileViews: [UIImageView] = []
    var cardWidth: CGFloat!
    var cardMargin: CGFloat!
    var cardRatio: CGFloat!
    var dealerAction: DealerAction!

    override func viewDidLoad() {
        super.viewDidLoad()
        cardWidth = UIScreen.main.bounds.width / 7
        cardMargin = cardWidth / 30
        cardRatio = CGFloat(1.27)
        dealerAction = DealerAction()
        dealerAction.shuffle()
        drawBackground()
        drawFoundations()
        drawDeck()
        drawSevenPiles()
    }

    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        super.motionBegan(motion, with: event)
        if motion == .motionShake {
            dealerAction.reset()
            dealerAction.shuffle()
            drawSevenPiles()
        }
    }

    private func drawBackground() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_pattern")!)
    }

    private func drawFoundations() {
        for i in 0..<4 {
            foundationViews.append(getFoundation(index: i))
            self.view.addSubview(foundationViews[i])
        }
    }

    private func getFoundation(index: Int) -> UIImageView {
        let statusBarMagin = CGFloat(20)
        let borderLayer = CALayer()
        let borderFrame = CGRect(origin: CGPoint(x: cardWidth * CGFloat(index) + cardMargin,
                                                 y: statusBarMagin),
                                 size: CGSize(width: cardWidth - 1.5 * cardMargin,
                                              height: cardWidth * cardRatio))
        borderLayer.backgroundColor = UIColor.clear.cgColor
        borderLayer.frame = borderFrame
        borderLayer.cornerRadius = 5.0
        borderLayer.borderWidth = 1.0
        borderLayer.borderColor = UIColor.white.cgColor
        let imageView = UIImageView()
        imageView.layer.addSublayer(borderLayer)
        return imageView
    }

    private func drawDeck() {
        let statusBarMagin = CGFloat(20)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: cardWidth * CGFloat(6) + cardMargin,
                                                                  y: statusBarMagin),
                                                  size: CGSize(width: cardWidth - 1.5 * cardMargin,
                                                               height: cardWidth * cardRatio)))
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
        let pileTopMargin = CGFloat(100)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: cardWidth * CGFloat(index) + cardMargin,
                                                                  y: pileTopMargin),
                                                  size: CGSize(width: cardWidth - 1.5 * cardMargin,
                                                               height: cardWidth * cardRatio)))
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

