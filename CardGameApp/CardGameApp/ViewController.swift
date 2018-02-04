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
    private var dealedPosition: CGPoint?
    private var vacantPosition: CGPoint?
    private var sparePosition: CGPoint?
    private var revealedPosition: CGPoint?
    private let maxStud = 7
    private let horizontalStackSpacing: CGFloat = 4
    private var vacantStackView: UIStackView? {
        didSet {
            guard let vacantStackView = vacantStackView else { return }
            view.addSubview(vacantStackView)
        }
    }
    private var dealedStackView: UIStackView? {
        didSet {
            guard let dealedStackView = dealedStackView else { return }
            view.addSubview(dealedStackView)
        }
    }
    private var spareStackView: SpareCardStackView? {
        didSet {
            guard let spareStackView = spareStackView else { return }
            view.addSubview(spareStackView)
        }
    }
    private var revealedStackView: CardViewStack? {
        didSet {
            guard let revealedStackView = revealedStackView else { return }
            view.addSubview(revealedStackView)
        }
    }
    var cardSize: CGSize {
        guard let view = view else { return CGSize() }
        let width = view.frame.size.width/7
        let height = width*1.27
        return CGSize(width: width, height: height)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // 배경 패턴 그림
        drawBackground()
        // 위치 지정
        vacantPosition = CGPoint(x: view.layoutMargins.left, y: view.layoutMargins.top)
        dealedPosition = CGPoint(x: view.layoutMargins.left, y: view.layoutMargins.top+cardSize.height+15)
        sparePosition = CGPoint(x: view.frame.width-(view.layoutMargins.right+cardSize.width)+horizontalStackSpacing,
                                y: view.layoutMargins.top)
        revealedPosition = CGPoint(x: sparePosition!.x-cardSize.width-horizontalStackSpacing,
                                        y: view.layoutMargins.top)
        initGameBoard()
    }

    private func initGameBoard() {
        // 덱 생성 및 셔플
        resetDeck()
        // 배치
        dealedStackView = dealedStackView(on: dealedPosition)
        vacantStackView = vacantStackView(of: 4, on: vacantPosition)
        addSpareStackView(sparePosition!, revealedPosition!)
    }

    private func addSpareStackView(_ sparePosition: CGPoint?, _ revealPosition: CGPoint?) {
        let spareCardViews = makeCardViews(from: deck?.remnants(), lastCardFaceToBeUp: false)
        let size = CGSize(width: cardSize.width-horizontalStackSpacing, height: cardSize.height)
        revealedStackView = CardViewStack([], CGRect(origin: revealPosition!, size: size))
        spareStackView = SpareCardStackView(spareCardViews,
                                            CGRect(origin: sparePosition!, size: size),
                                            revealedStackView: revealedStackView)
    }

    private func resetDeck() {
        deck = Deck()
        deck?.shuffle()
    }

    private func resetGameBoard() {
        // 덱 생성 및 셔플
        resetDeck()
        // 배치
        dealedStackView = dealedStackView(on: dealedPosition)
        vacantStackView = vacantStackView(of: 4, on: vacantPosition)
        spareStackView?.reset()
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            resetGameBoard()
        }
    }

    private func dealedStackView(on position: CGPoint?) -> UIStackView? {
        guard let position = position else { return nil }
        let cardInfos = dealedCardInfos()
        let verticalStackViews = makeCardViewStacks(using: cardInfos)
        let horizontalStackView = UIStackView(frame: CGRect(origin: position,
                                                            size: CGSize(width: view.frame.width,
                                                                         height: view.frame.height-position.y)))
        for stack in verticalStackViews {
            horizontalStackView.addArrangedSubview(stack)
        }
        horizontalStackView.configureStackSetting(axis: .horizontal,
                                                  distribution: .fillEqually,
                                                  spacing: horizontalStackSpacing)
        return horizontalStackView
    }

    private func makeCardViewStacks(using cardStacks: [CardStack?]) -> [CardViewStack] {
        var cardViewStacks: [CardViewStack] = []
        cardStacks.forEach { cardInfos in
            let cardViews = makeCardViews(from: cardInfos, lastCardFaceToBeUp: true)
            let cardViewStack = CardViewStack(cardViews, .zero)
            cardViewStack.configureStackSetting(axis: .vertical,
                                                distribution: .fill,
                                                spacing: -cardSize.height*0.7)
            // 스택뷰 높이 - ((가려진 카드 높이) x (총 카드개수-1개) + 마지막 카드높이)
            let bottomMargin =
                (view.frame.height-dealedPosition!.y)-(CGFloat(cardViews.count-1)*cardSize.height*0.3+cardSize.height)
            cardViewStack.setBottomLayoutMargins(bottomMargin)
            cardViewStacks.append(cardViewStack)
        }
        return cardViewStacks
    }

    private func dealedCardInfos() -> [CardStack?] {
        var verticalCardStacks: [CardStack?] = []
        for numberOfCards in 0..<maxStud {
            let cardStack = deck?.drawMany(selectedCount: numberOfCards+1)
            verticalCardStacks.append(cardStack)
        }
        return verticalCardStacks
    }

    private func makeCardViews(from cardInfos: CardStack?, lastCardFaceToBeUp: Bool) -> [CardView] {
        var cardViews: [CardView] = []
        cardInfos?.forEach({ (cardInfo) in
            let newCardView = makeCardView(cardInfo)
            cardViews.append(newCardView)
        })
        cardViews.last?.turnOver(lastCardFaceToBeUp)
        return cardViews
    }

    private func makeCardView(_ cardInfo: Card) -> CardView {
        let frontImage = UIImage(imageLiteralResourceName: cardInfo.description)
        let backImage = UIImage(imageLiteralResourceName: "card-back")
        let newCardView = CardView(frame: .zero, frontImage: frontImage, backImage: backImage)
        newCardView.setSizeConstraint(to: self.cardSize)
        return newCardView
    }

    private func vacantStackView(of count: Int, on position: CGPoint?) -> UIStackView? {
        guard let position = position else { return nil }
        let vacantStack = UIStackView(frame: CGRect(origin: position,
                                                    size: CGSize(width: view.frame.width-cardSize.width*3,
                                                                 height: cardSize.height)))
        vacantStack.configureStackSetting(axis: .horizontal,
                                          distribution: .fillEqually,
                                          spacing: horizontalStackSpacing)
        for _ in 0..<count {
            let vacantView = CardView(frame: .zero, frontImage: nil, backImage: nil)
            vacantView.setSizeConstraint(to: self.cardSize)
            vacantStack.addArrangedSubview(vacantView)
        }
        return vacantStack
    }

    private func drawBackground() {
        view.backgroundColor = UIColor(patternImage: .init(imageLiteralResourceName: "bg_pattern"))
        viewRespectsSystemMinimumLayoutMargins = false
        view.layoutMargins = UIEdgeInsets(top: UIApplication.shared.statusBarFrame.height,
                                          left: 0,
                                          bottom: 5,
                                          right: 0)
    }

}
