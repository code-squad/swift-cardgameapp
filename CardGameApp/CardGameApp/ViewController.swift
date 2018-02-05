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

    private lazy var revealedCardViewStack: CardViewStack = {
        let size = CGSize(width: cardSize.width-Constants.GameBoard.horizontalStackSpacing, height: cardSize.height)
        return CardViewStack(frame: CGRect(origin: revealedPosition!, size: size), cardViews: [])
    }()

    private lazy var spareCardViewStack: SpareCardViewStack = {
        let spareCardViews = makeCardViews(count: deck?.remnants().count ?? 0)
        let size = CGSize(width: cardSize.width-Constants.GameBoard.horizontalStackSpacing, height: cardSize.height)
        let spareCardViewStack = SpareCardViewStack(frame: CGRect(origin: sparePosition!, size: size),
                                                    cardViews: spareCardViews,
                                                    revealedStackView: revealedCardViewStack)
        return spareCardViewStack
    }()

    private lazy var vacantCardViewStack: VacantCardViewStack = {
        return VacantCardViewStack(
            frame: CGRect(origin: vacantPosition!,
                          size: CGSize(width: view.frame.width-cardSize.width*3, height: cardSize.height)),
            sizeOf: cardSize,
            spaceCount: Constants.GameBoard.vacantSpaceCount,
            spacing: Constants.GameBoard.horizontalStackSpacing)
    }()

    private lazy var dealedCardViewStackContainer: DealedCardViewStackContainer = {
        let verticalCardViewStacks = dealedCardViewStacks(of: Constants.GameBoard.maxStud)
        let frame = CGRect(origin: dealedPosition!,
                           size: CGSize(width: view.frame.width,
                                        height: view.frame.height-dealedPosition!.y))
        return DealedCardViewStackContainer(frame: frame,
                                            dealedCardViewStacks: verticalCardViewStacks,
                                            spacing: Constants.GameBoard.horizontalStackSpacing)
    }()

    private lazy var cardSize: CGSize = {
        guard let view = view else { return CGSize() }
        let width = view.frame.size.width/7
        let height = width*1.27
        return CGSize(width: width, height: height)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 배경 패턴 그림
        drawBackground()
        // 위치 지정
        vacantPosition = CGPoint(x: view.layoutMargins.left, y: view.layoutMargins.top)
        dealedPosition = CGPoint(x: view.layoutMargins.left, y: view.layoutMargins.top+cardSize.height+15)
        let spareX = view.frame.width -
                        (view.layoutMargins.right+cardSize.width)+Constants.GameBoard.horizontalStackSpacing
        sparePosition = CGPoint(x: spareX, y: view.layoutMargins.top)
        revealedPosition = CGPoint(x: sparePosition!.x-cardSize.width-Constants.GameBoard.horizontalStackSpacing,
                                        y: view.layoutMargins.top)
        initGameBoard()
        // 배치
        view.addSubview(dealedCardViewStackContainer)
        view.addSubview(vacantCardViewStack)
        view.addSubview(spareCardViewStack)
        view.addSubview(revealedCardViewStack)
    }

    private func initGameBoard() {
        // 덱 생성 및 셔플
        resetDeck()
        dealedCardViewStackContainer.arrangedSubviews.forEach { (subview) in
            (subview as? DealedCardViewStack)?.dataSource = self
        }
        spareCardViewStack.dataSource = self
    }

    private func resetDeck() {
        deck = Deck()
        deck?.shuffle()
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            initGameBoard()
            spareCardViewStack.reset()
        }
    }

    private func drawBackground() {
        view.backgroundColor = UIColor(patternImage: .init(imageLiteralResourceName: Constants.ImageName.background))
        viewRespectsSystemMinimumLayoutMargins = false
        view.layoutMargins = UIEdgeInsets(top: UIApplication.shared.statusBarFrame.height,
                                          left: 0,
                                          bottom: 5,
                                          right: 0)
    }

}

extension ViewController: CardViewStackDataSource {
    func spareCards() -> CardStack? {
        let remnants = deck?.remnants()
        return remnants
    }

    func dealedCards(_ stud: Int) -> CardStack? {
        let dealedCards = deck?.drawMany(selectedCount: stud)
        return dealedCards
    }
}

extension ViewController {
    private func dealedCardViewStacks(of maxStud: Int) -> [DealedCardViewStack] {
        var dealedCardViewStacks: [DealedCardViewStack] = []
        for stud in 1...Constants.GameBoard.maxStud {
            let dealedCardViewStack = dealCardViewStack(of: stud)
            dealedCardViewStacks.append(dealedCardViewStack)
        }
        return dealedCardViewStacks
    }

    private func dealCardViewStack(of stud: Int) -> DealedCardViewStack {
        let cardViews = makeCardViews(count: stud)
        let spacing = -cardSize.height*0.7
        let cardCount = cardViews.count
        let bottomMarginToLastCard =
            (view.frame.height-dealedPosition!.y)-(CGFloat(cardCount-1)*cardSize.height*0.3+cardSize.height)
        return DealedCardViewStack(frame: .zero, cardViews: cardViews,
                                   spacing: spacing, bottomMargin: bottomMarginToLastCard)
    }

    private func makeCardViews(count: Int) -> [CardView] {
        var cardViews: [CardView] = []
        for _ in 0..<count {
            let newCardView = CardView(sizeOf: cardSize)
            cardViews.append(newCardView)
        }
        return cardViews
    }

}
