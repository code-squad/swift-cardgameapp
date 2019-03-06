//
//  ViewController.swift
//  CardGameApp
//
//  Created by 윤동민 on 19/02/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var cardStacksView: CardStacksView?         // 카드 스택들 뷰
    private var spacesView: CardSpacesView?             // 카드 빈공간들 뷰
    private var deckView: CardDeckView?                 // 카드 덱 뷰
    private var reversedCardsView: ReversedCardsView?   // 뒤집힌 카드 뷰

    private var cardStacks: [CardStack] = []            // 모델 카드 스택들
    private var spacesCardStacks: [CardStack] = []      // 모델 카드 빈공간
    private var cardDeck: CardDeck = CardDeck()         // 모델 카드 덱
    private var reversedCards: CardStack = CardStack()  // 모델 뒤집힌 카드
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(addDoubleTapRecognizer(_:)), name: .createdCardView, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeOneCardFromDeck), name: .touchedDeck, object: nil)
        
        setBackgroundPattern()
        initialCardStacks()
        initialSpacesStacks()
        initialSpacesView()
        initialViews()
        initialDeckView()
        initialReversedView()
    }
    
    @objc func removeOneCardFromDeck() {
        guard let pickedCard = cardDeck.removeOne() else { return }
        reversedCards.add(pickedCard)
        reversedCardsView?.addViewFromDeck(card: pickedCard)
    }
    
    private func initialReversedView() {
        let positionX = Int(spacesView!.frame.maxX) + Int((deckView!.frame.minX - spacesView!.frame.maxX)) / 2 - Sizes.cardWitdh / 2
        reversedCardsView = ReversedCardsView(frame: CGRect(x: positionX, y: Sizes.viewFirstY, width: Sizes.cardWitdh, height: Sizes.cardHeight))
        self.view.addSubview(reversedCardsView!)
    }
    
    private func initialDeckView() {
        let positionX = Sizes.viewFirstX + Sizes.cardWitdh * 6 + 5 * 6
        let positionY = Sizes.viewFirstY
        deckView = CardDeckView(frame: CGRect(x: positionX, y: positionY, width: Sizes.cardWitdh, height: Sizes.cardHeight), cardDeck)
        self.view.addSubview(deckView!)
    }
    
    private func setBackgroundPattern() {
        self.view.backgroundColor = UIColor.init(patternImage: UIImage(named: "bg_pattern")!)
    }
    
    private func initialCardStacks() {
        for count in 1..<8 {
            let cardStack: CardStack = CardStack()
            for _ in 0..<count {
                guard let card = cardDeck.removeOne() else { return }
                cardStack.add(card)
            }
            cardStacks.append(cardStack)
        }
    }
    
    private func initialSpacesStacks() {
        for _ in 1...4 {
            let cardStack: CardStack = CardStack()
            spacesCardStacks.append(cardStack)
        }
    }
    
    private func initialSpacesView() {
        var spaces: [SpaceView] = []
        for _ in 1...4 {
            let spaceView = SpaceView(frame: CGRect(x: Sizes.originX, y: Sizes.originY, width: Sizes.cardWitdh, height: Sizes.cardHeight))
            spaces.append(spaceView)
        }
        let spacesViewWidth = Sizes.cardWitdh * spaces.count + (spaces.count-1) * 5
        spacesView = CardSpacesView(frame: CGRect(x: Sizes.viewFirstX, y: Sizes.viewFirstY, width: spacesViewWidth, height: Sizes.cardHeight), spaces)
        self.view.addSubview(spacesView!)
    }
    
    private func initialViews() {
        let width = Int(UIScreen.main.bounds.width) - Sizes.viewFirstX * 2
        let height = Int(UIScreen.main.bounds.height) - Sizes.viewSecondY
        cardStacksView = CardStacksView(frame: CGRect(x: Sizes.viewFirstX, y: Sizes.viewSecondY, width: width, height: height), cardStacks)
        self.view.addSubview(cardStacksView!)
    }
}

extension ViewController {
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            cardStacksView?.removeFromSuperview()
            spacesView?.removeFromSuperview()
            deckView?.removeFromSuperview()
            reversedCardsView?.removeFromSuperview()

            cardDeck.reset()
            cardDeck.shuffle()
            cardStacks.removeAll()
            initialCardStacks()
            reversedCards.removeAll()
            spacesCardStacks.removeAll()
            initialSpacesStacks()
    
            initialSpacesView()
            initialViews()
            initialDeckView()
            initialReversedView()
        }
    }
}

// CardView Tap시 일어나는 동작 구현
extension ViewController {
    @objc func addDoubleTapRecognizer(_ notification: NSNotification) {
        let recog = UITapGestureRecognizer(target: self, action: #selector(tapCard(_:)))
        recog.numberOfTapsRequired = 2
        
        guard let cardView = notification.userInfo?["card"] as? CardView else { return }
        cardView.addGestureRecognizer(recog)
        cardView.isUserInteractionEnabled = true
    }
    
    @objc func tapCard(_ gesture: UIGestureRecognizer) {
        var touchedStackNum: Int = 0
        let touchedX = gesture.location(in: self.view).x
        for stackNumber in 1...7 {
            if touchedX >= CGFloat(Sizes.viewFirstX + Sizes.cardWitdh * (stackNumber-1) + 5 * (stackNumber-1))
                && touchedX <= CGFloat(Sizes.viewFirstX + Sizes.cardWitdh * stackNumber + 5 * (stackNumber-1)) {
                touchedStackNum = stackNumber
                break
            }
        }
        animateCardByRule(touchedStackNum)
    }
    
    private func animateCardByRule(_ number: Int) {
        if cardStacks[number-1].isLastCardOne() { animateOneCard(number) }
    }
    
    private func animateOneCard(_ number: Int) {
        guard let removeCard = cardStacks[number-1].removeOne() else { return }
        cardStacksView?.removeCardView(at: number-1)
        cardStacksView?.turnLastCard(at: number-1, stackModel: cardStacks[number-1])
        
        for index in 0..<spacesCardStacks.count {
            if spacesCardStacks[index].isEmpty() {
                spacesCardStacks[index].add(removeCard)
                spacesView?.addCardView(at: index, card: removeCard)
                break
            }
        }
    }
}

