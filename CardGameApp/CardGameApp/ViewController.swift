//
//  ViewController.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 1. 30..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var deck: Deck?
    override func viewDidLoad() {
        super.viewDidLoad()
        initGameBoard()
    }

    private func initGameBoard() {
        drawBackground()
        reset()
        vacantPosition = CGPoint(x: view.layoutMargins.left, y: view.layoutMargins.top)
        sparePosition = CGPoint(x: view.frame.width-(view.layoutMargins.right+cardSize.width),
                                y: view.layoutMargins.top)
        dealedPosition = CGPoint(x: view.layoutMargins.left, y: view.layoutMargins.top+cardSize.height+15)
        drawVacantSpaces(4, on: vacantPosition)
        lay(cards: deck?.drawMany(selectedCount: 1), on: sparePosition, false)
        lay(cards: deck?.drawMany(selectedCount: 7), on: dealedPosition, true)
    }

    private func reset() {
        deck = Deck()
        deck?.shuffle()
    }

    private var vacantPosition: CGPoint?
    private var sparePosition: CGPoint?
    private var dealedPosition: CGPoint?

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            reset()
            lay(cards: deck?.drawMany(selectedCount: 1), on: sparePosition, false)
            lay(cards: deck?.drawMany(selectedCount: 7), on: dealedPosition, true)
        }
    }

    private func drawBackground() {
        view.backgroundColor = UIColor(patternImage: .init(imageLiteralResourceName: "bg_pattern"))
        viewRespectsSystemMinimumLayoutMargins = false
        view.layoutMargins = UIEdgeInsets(top: UIApplication.shared.statusBarFrame.height,
                                          left: 0,
                                          bottom: 5,
                                          right: 0)
    }

    private func lay(cards: CardStack?, on position: CGPoint?, _ faceToBeUp: Bool) {
        guard var position = position else { return }
        cards?.forEach { card in
            let cardView = makeCardView(card, position, faceToBeUp)
            view.addSubview(cardView)
            position = CGPoint(x: cardView.frame.maxX, y: position.y)
        }
    }

    private func drawVacantSpaces(_ count: Int, on position: CGPoint?) {
        guard var position = position else { return }
        for _ in 0..<count {
            let vacantSpace = makeVacantSpace(position)
            view.addSubview(vacantSpace)
            position = CGPoint(x: vacantSpace.frame.maxX, y: position.y)
        }
    }

    private func makeCardView(_ cardInfo: Card, _ origin: CGPoint, _ faceToBeUp: Bool) -> CardView {
        let newCardView = CardView(frame: CGRect(origin: origin, size: cardSize))
        newCardView.frontImage = UIImage(imageLiteralResourceName: cardInfo.description)
        faceToBeUp ? newCardView.turnOver(true) : newCardView.turnOver(false)
        return newCardView
    }

    private func makeVacantSpace(_ origin: CGPoint) -> CardView {
        let vacantSpace = CardView(frame: CGRect(origin: origin, size: cardSize))
        vacantSpace.isVacant = true
        return vacantSpace
    }

    private var cardSize: CGSize {
        guard let view = view else { return CGSize() }
        let width = view.frame.size.width/7
        let height = width*1.27
        return CGSize(width: width, height: height)
    }

}
