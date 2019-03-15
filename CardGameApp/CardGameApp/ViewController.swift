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
    private var spaceCardStacks: [CardStack] = []       // 모델 카드 빈공간
    private var cardDeck: CardDeck = CardDeck()         // 모델 카드 덱
    private var reversedCards: CardStack = ReversedCardStack() // 모델 뒤집힌 카드
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(removeOneCardFromDeck), name: .touchedDeck, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(excuteWhenTapped(_:)), name: .tappedCardView, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addReversedCardView(_:)), name: .addReversedCard, object: nil)
        
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
    }
    
    @objc func addReversedCardView(_ notification: NSNotification) {
        guard let card = notification.userInfo?["card"] as? Card else { return }
        reversedCardsView?.addView(card: card)
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
            spaceCardStacks.append(cardStack)
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
            spaceCardStacks.removeAll()
            initialSpacesStacks()
    
            initialSpacesView()
            initialViews()
            initialDeckView()
            initialReversedView()
        }
    }
}

enum TappedCard {
    case reversed
    case stack(Int)
}

// CardView Tap시 일어나는 동작 구현
extension ViewController {
    @objc func excuteWhenTapped(_ notification: NSNotification) {
        guard let touchedPoint = notification.userInfo?["touchedPoint"] as? CGPoint else { return }
        let tappedView: TappedCard = searchTappedCardView(touched: touchedPoint)

        switch tappedView {
        case .reversed: checkRuleFromReversed()
        case .stack(let number): checkRuleFromStack(number: number)
        }
    }
    
    private func searchTappedCardView(touched: CGPoint) -> TappedCard {
        if touched.y >= CGFloat(Sizes.viewFirstY) && touched.y <= CGFloat(Sizes.cardHeight + Sizes.viewFirstY) { return .reversed }
        else {
            for stackNumber in 1...7 {
                if touched.x >= CGFloat(Sizes.viewFirstX + Sizes.cardWitdh * (stackNumber-1) + 5 * (stackNumber-1))
                    && touched.x <= CGFloat(Sizes.viewFirstX + Sizes.cardWitdh * stackNumber + 5 * (stackNumber-1)) {
                    return .stack(stackNumber)
                }
            }
        }
        return .stack(1)
    }
    
    private func isMoveToSpace(_ cardOnTop: Card) -> Bool {
        var isMove: Bool = false
        
        for index in 0..<spaceCardStacks.count {
            spaceCardStacks[index].accessCard { spaceCards in
                guard !spaceCards.isEmpty else { return }
                let spaceCardOnTop = spaceCards[spaceCards.count-1]
                
                guard cardOnTop < spaceCardOnTop else { return }
                isMove = true
            }
            if isMove { return true }
        }
        return false
    }
}

// Reversed View에서 일어나는 동작 구현
extension ViewController {
    private func checkRuleFromReversed() {
        reversedCards.accessCard { cards in
            let reversedCardsOnTop = cards[cards.count-1]
            
            if reversedCardsOnTop.number == .one { animateOneCardFromReversed() }
            else if reversedCardsOnTop.number == .thirteen { animateKCardFromRevered() }
            else if isMoveToSpace(reversedCardsOnTop) { animateReversedToSpace(reversedCardsOnTop) }
            else { animateReversedToStack(reversedCardsOnTop) }
        }
    }
    
    private func animateOneCardFromReversed() {
        for index in 0..<spaceCardStacks.count {
            if spaceCardStacks[index].isEmpty() {
                UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
                    let distance: CGFloat = (self.reversedCardsView?.frame.origin.x)! - CGFloat((Sizes.viewFirstX + 5*index + Sizes.cardWitdh*index))
                    self.reversedCardsView?.acceesTopView { topView in
                        topView.transform = CGAffineTransform(translationX: -distance, y: 0)
                    }
                }, completion: { isTrue in
                    self.reversedCardsView?.acceesTopView { topView in
                        topView.transform = CGAffineTransform(translationX: 0, y: 0)
                    }
                    guard let removeCard = self.reversedCards.removeOne() else { return }
                    guard let removeCardView = self.reversedCardsView?.removeView() else { return }
                    self.spaceCardStacks[index].add(removeCard)
                    self.spacesView?.addCardView(at: index, view: removeCardView)
                })
                break
            }
        }
    }
    
    private func animateKCardFromRevered() {
        for index in 0..<cardStacks.count {
            if cardStacks[index].isEmpty() {
                UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
                    let distanceX = (self.reversedCardsView?.frame.origin.x)! - CGFloat((Sizes.viewFirstX + 5*index + Sizes.cardWitdh*index))
                    let distanceY = CGFloat(Sizes.viewSecondY - Sizes.viewFirstY)
                    self.reversedCardsView?.acceesTopView { topView in
                        topView.transform = CGAffineTransform(translationX: -distanceX, y: distanceY)
                    }
                }, completion: { isTrue in
                    self.reversedCardsView?.acceesTopView { topView in
                        topView.transform = CGAffineTransform(translationX: 0, y: 0)
                    }
                    guard let removeCard = self.reversedCards.removeOne() else { return }
                    guard let removeCardView = self.reversedCardsView?.removeView() else { return }
                    self.cardStacks[index].add(removeCard)
                    self.cardStacksView?.addCardView(at: index, view: removeCardView)
                })
                break
            }
        }
    }
    
    private func animateReversedToSpace(_ cardOnTop: Card) {
        for index in 0..<spaceCardStacks.count {
            spaceCardStacks[index].accessCard { spaceCards in
                if spaceCards.isEmpty { return }
                let spaceCardOnTop = spaceCards[spaceCards.count-1]
                
                guard cardOnTop.shape == spaceCardOnTop.shape else { return }
                
                UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
                    self.reversedCardsView?.acceesTopView { topView in
                        let distanceX = (self.reversedCardsView?.frame.origin.x)! - CGFloat((Sizes.viewFirstX + 5*index + Sizes.cardWitdh*index))
                        topView.transform = CGAffineTransform(translationX: -distanceX, y: 0)
                    }
                }, completion: { isTrue in
                    self.reversedCardsView?.acceesTopView { topView in
                        topView.transform = CGAffineTransform(translationX: 0, y: 0)
                    }
                    guard let removeCard = self.reversedCards.removeOne() else { return }
                    guard let removeCardView = self.reversedCardsView?.removeView() else { return }
                    self.spaceCardStacks[index].add(removeCard)
                    self.spacesView?.addCardView(at: index, view: removeCardView)
                })
            }
        }
    }
    
    private func animateReversedToStack(_ cardOnTop: Card) {
        var isOver = false
        for index in 0..<cardStacks.count {
            cardStacks[index].accessCard { stackCards in
                guard !stackCards.isEmpty else { return }
                let stackCardOnTop = stackCards[stackCards.count-1]
                
                guard cardOnTop.number.rawValue+1 == stackCardOnTop.number.rawValue else { return }
                guard cardOnTop == stackCardOnTop else { return }
                
                UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
                    self.reversedCardsView?.acceesTopView { topView in
                        let distanceX = (self.reversedCardsView?.frame.origin.x)! - CGFloat((Sizes.viewFirstX + 5*index + Sizes.cardWitdh*index))
                        let distanceY = CGFloat(Sizes.viewSecondY + Sizes.stackCardsSpace*stackCards.count - Sizes.viewFirstY)
                        topView.transform = CGAffineTransform(translationX: -distanceX, y: distanceY)
                    }
                }, completion: { isTrue in
                    self.reversedCardsView?.acceesTopView { topView in
                        topView.transform = CGAffineTransform(translationX: 0, y: 0)
                    }
                    guard let removeCard = self.reversedCards.removeOne() else { return }
                    guard let removeCardView = self.reversedCardsView?.removeView() else { return }
                    self.cardStacks[index].add(removeCard)
                    self.cardStacksView?.addCardView(at: index, view: removeCardView)
                    isOver = true
                })
            }
            if isOver { return }
        }
    }
}

// Stacks View에서 일어나는 동작 구현
extension ViewController {
    private func checkRuleFromStack(number: Int) {
        cardStacks[number-1].accessCard { cards in
            let cardStackOnTop = cards[cards.count-1]
            
            if cardStackOnTop.number == .one { animateOneCardFromStack(number) }
            else if cardStackOnTop.number == .thirteen { animateKCardFromStack(number) }
            else if isMoveToSpace(cardStackOnTop) { animateStackToSpace(from: number, cardStackOnTop) }
            else { animateStackToStack(from: number, cardStackOnTop) }
        }
    }
    
    private func animateOneCardFromStack(_ number: Int) {
        for index in 0..<spaceCardStacks.count {
            if spaceCardStacks[index].isEmpty() {
                UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
                    self.cardStacksView?.accessTopView(at: number-1) { topView in
                        let distanceX = CGFloat((number-1-index)*Sizes.cardWitdh + (number-1-index)*5)
                        let distanceY = CGFloat(Sizes.viewSecondY + Sizes.stackCardsSpace*(self.cardStacks[number-1].count()-1) - Sizes.viewFirstY)
                        topView.transform = CGAffineTransform(translationX: -distanceX, y: -distanceY)
                    }
                }, completion: { isTrue in
                    guard let removeCard = self.cardStacks[number-1].removeOne() else { return }
                    guard let removeCardView = self.cardStacksView?.removeCardView(at: number-1) else { return }
                    if !self.cardStacks[number-1].isEmpty() { self.cardStacksView?.turnLastCard(at: number-1, stackModel: self.cardStacks[number-1]) }
                    self.spaceCardStacks[index].add(removeCard)
                    self.spacesView?.addCardView(at: index, view: removeCardView)
                })
                break
            }
        }
    }
    
    private func animateKCardFromStack(_ number: Int) {
        for index in 0..<cardStacks.count {
            if cardStacks[index].isEmpty() && index != number-1 {
                UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
                    self.cardStacksView?.accessTopView(at: number-1) { topView in
                        let distanceX = CGFloat((number-1-index)*Sizes.cardWitdh + (number-1-index)*5)
                        let distanceY = CGFloat((self.cardStacks[number-1].count() - self.cardStacks[index].count()) * Sizes.stackCardsSpace)
                        topView.transform = CGAffineTransform(translationX: -distanceX, y: -distanceY)
                    }
                }, completion: { isTrue in
                    guard let removeCard = self.cardStacks[number-1].removeOne() else { return }
                    guard let removeCardView = self.cardStacksView?.removeCardView(at: number-1) else { return }
                    if !self.cardStacks[number-1].isEmpty() { self.cardStacksView?.turnLastCard(at: number-1, stackModel: self.cardStacks[number-1]) }
                    self.cardStacks[index].add(removeCard)
                    self.cardStacksView?.addCardView(at: index, view: removeCardView)
                })
                break
            }
        }
    }
    
    private func animateStackToSpace(from number: Int, _ cardOnTop: Card) {
        for index in 0..<spaceCardStacks.count {
            spaceCardStacks[index].accessCard { spaceCards in
                if spaceCards.isEmpty { return }
                let spaceCardOnTop = spaceCards[spaceCards.count-1]
                
                guard cardOnTop.shape == spaceCardOnTop.shape else { return }
                
                UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
                    self.cardStacksView?.accessTopView(at: number-1) { topView in
                        let distanceX = CGFloat((number-1-index)*Sizes.cardWitdh + (number-1-index)*5)
                        let distanceY = CGFloat(Sizes.viewSecondY + Sizes.stackCardsSpace*(self.cardStacks[number-1].count()-1) - Sizes.viewFirstY)
                        topView.transform = CGAffineTransform(translationX: -distanceX, y: -distanceY)
                    }
                }, completion: { isTrue in
                    guard let removeCard = self.cardStacks[number-1].removeOne() else { return }
                    guard let removeCardView = self.cardStacksView?.removeCardView(at: number-1) else { return }
                    if !self.cardStacks[number-1].isEmpty() { self.cardStacksView?.turnLastCard(at: number-1, stackModel: self.cardStacks[number-1]) }
                    self.spaceCardStacks[index].add(removeCard)
                    self.spacesView?.addCardView(at: index, view: removeCardView)
                })
            }
        }
    }
    
    private func animateStackToStack(from number: Int, _ cardOnTop: Card) {
        var isOver = false
        for index in 0..<cardStacks.count {
            cardStacks[index].accessCard { cards in
                guard !cards.isEmpty else { return }
                let stackCardOnTop = cards[cards.count-1]
                guard cardOnTop !== stackCardOnTop else { return }
                
                guard cardOnTop.number.rawValue+1 == stackCardOnTop.number.rawValue else { return }
                guard cardOnTop == stackCardOnTop else { return }
                
                UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
                    self.cardStacksView?.accessTopView(at: number-1) { topView in
                        let distanceX = CGFloat((number-1-index)*Sizes.cardWitdh + (number-1-index)*5)
                        var distanceY = CGFloat(self.cardStacks[number-1].count() - self.cardStacks[index].count())
                        if distanceY >= 0 { distanceY = (distanceY+1) * CGFloat(Sizes.stackCardsSpace) }
                        else { distanceY = (distanceY-1) * CGFloat(Sizes.stackCardsSpace) }
                        topView.transform = CGAffineTransform(translationX: -distanceX, y: -distanceY)
                    }
                }, completion: { isTrue in
                    guard let removeCard = self.cardStacks[number-1].removeOne() else { return }
                    guard let removeCardView = self.cardStacksView?.removeCardView(at: number-1) else { return }
                    if !self.cardStacks[number-1].isEmpty() { self.cardStacksView?.turnLastCard(at: number-1, stackModel: self.cardStacks[number-1]) }
                    self.cardStacks[index].add(removeCard)
                    self.cardStacksView?.addCardView(at: index, view: removeCardView)
                    isOver = true
                })
            }
            if isOver { return }
        }
    }
}

