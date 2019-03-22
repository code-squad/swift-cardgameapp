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
    
    var pastPoint: CGPoint?
    var startTouchStackNumber: Int?
    var startTouchDepth: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(removeOneCardFromDeck), name: .touchedDeck, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(excuteWhenTapped(_:)), name: .tappedCardView, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addReversedCardView(_:)), name: .addReversedCard, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(baganDrag(_:)), name: .beganDragView, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(excuteWhenDrag(_:)), name: .draggingView, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(endDrag(_:)), name: .endedDragView, object: nil)
        
        setBackgroundPattern()
        initialCardStacks()
        initialSpacesStacks()
        initialSpacesView()
        initialViews()
        initialReversedView()
        initialDeckView()
    }
    
    @objc func removeOneCardFromDeck() {
        guard let pickedCard = cardDeck.removeOne() else { return }
        reversedCards.add(pickedCard)
    }
    
    @objc func addReversedCardView(_ notification: NSNotification) {
        guard let card = notification.userInfo?["card"] as? Card else { return }
        deckView?.accessTopView { topView in
            topView.setCardImage(name: card.description)
        }
        
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
                let distanceX = self.deckView!.frame.maxX - self.reversedCardsView!.frame.maxX
                self.deckView?.accessTopView { topView in
                    topView.transform = CGAffineTransform(translationX: -distanceX, y: 0)
                }
            }, completion: { isAnimate in
                guard isAnimate else { return }
                self.deckView?.accessTopView { topView in
                    topView.transform = CGAffineTransform(translationX: 0, y: 0)
                }
                guard let removeView = self.deckView?.removeView() else { return }
                self.reversedCardsView?.addView(removeView)
        })
    }
    
    private func initialReversedView() {
        let positionX = Int(spacesView!.frame.maxX) + Int((CGFloat(Sizes.deckViewX) - spacesView!.frame.maxX)) / 2 - Sizes.cardWitdh / 2
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
        startTouchDepth = nil
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
                }, completion: { isAnimate in
                    guard isAnimate else { return }
                    self.reversedCardsView?.acceesTopView { topView in
                        topView.transform = CGAffineTransform(translationX: 0, y: 0)
                        topView.isUserInteractionEnabled = false
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
                }, completion: { isAnimate in
                    guard isAnimate else { return }
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
            if !spaceCardStacks[index].isEmpty() {
                if spaceCardStacks[index].accessLastCard(form: { topCard in
                    guard cardOnTop.shape == topCard.shape else { return false }
                    
                    UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
                        self.reversedCardsView?.acceesTopView { topView in
                            let distanceX = (self.reversedCardsView?.frame.origin.x)! - CGFloat((Sizes.viewFirstX + 5*index + Sizes.cardWitdh*index))
                            topView.transform = CGAffineTransform(translationX: -distanceX, y: 0)
                        }
                    }, completion: { isAnimate in
                        guard isAnimate else { return }
                        self.reversedCardsView?.acceesTopView { topView in
                            topView.transform = CGAffineTransform(translationX: 0, y: 0)
                            topView.isUserInteractionEnabled = false
                        }
                        guard let removeCard = self.reversedCards.removeOne() else { return }
                        guard let removeCardView = self.reversedCardsView?.removeView() else { return }
                        self.spaceCardStacks[index].add(removeCard)
                        self.spacesView?.addCardView(at: index, view: removeCardView)
                    })
                    return true
                }) { break }
            }
        }
    }
    
    private func animateReversedToStack(_ cardOnTop: Card) {
        for index in 0..<cardStacks.count {
            if !cardStacks[index].isEmpty() {
                if cardStacks[index].accessLastCard(form: { topCard in
                    guard cardOnTop.number.rawValue+1 == topCard.number.rawValue else { return false }
                    guard cardOnTop == topCard else { return false }
            
                    UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
                        self.reversedCardsView?.acceesTopView { topView in
                            let distanceX = (self.reversedCardsView?.frame.origin.x)! - CGFloat((Sizes.viewFirstX + 5*index + Sizes.cardWitdh*index))
                            let distanceY = CGFloat(Sizes.viewSecondY + Sizes.stackCardsSpace*self.cardStacks[index].count() - Sizes.viewFirstY)
                            topView.transform = CGAffineTransform(translationX: -distanceX, y: distanceY)
                        }
                    }, completion: { isAnimate in
                        guard isAnimate else { return }
                        self.reversedCardsView?.acceesTopView { topView in
                            topView.transform = CGAffineTransform(translationX: 0, y: 0)
                        }
                        guard let removeCard = self.reversedCards.removeOne() else { return }
                        guard let removeCardView = self.reversedCardsView?.removeView() else { return }
                        self.cardStacks[index].add(removeCard)
                        self.cardStacksView?.addCardView(at: index, view: removeCardView)
                    })
                    return true
                }) { break }
            }
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
                }, completion: { isAnimate in
                    guard isAnimate else { return }
                    self.cardStacksView?.accessTopView(at: number-1) { topView in
                        topView.isUserInteractionEnabled = false
                        topView.transform = CGAffineTransform(translationX: 0, y: 0)
                    }
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
                        let distanceY = CGFloat((self.cardStacks[number-1].count()-1) * Sizes.stackCardsSpace)
                        topView.transform = CGAffineTransform(translationX: -distanceX, y: -distanceY)
                    }
                }, completion: { isAnimate in
                    guard isAnimate else { return }
                    self.cardStacksView?.accessTopView(at: number-1) { topView in
                        topView.transform = CGAffineTransform(translationX: 0, y: 0)
                    }
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
            if !spaceCardStacks[index].isEmpty() {
                if spaceCardStacks[index].accessLastCard(form: { topCard in
                    guard cardOnTop.shape == topCard.shape else { return false }
                    
                    UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
                        self.cardStacksView?.accessTopView(at: number-1) { topView in
                            let distanceX = CGFloat((number-1-index)*Sizes.cardWitdh + (number-1-index)*5)
                            let distanceY = CGFloat(Sizes.viewSecondY + Sizes.stackCardsSpace*(self.cardStacks[number-1].count()-1) - Sizes.viewFirstY)
                            topView.transform = CGAffineTransform(translationX: -distanceX, y: -distanceY)
                        }
                    }, completion: { isAnimate in
                        guard isAnimate else { return }
                        self.cardStacksView?.accessTopView(at: number-1) { topView in
                            topView.isUserInteractionEnabled = false
                            topView.transform = CGAffineTransform(translationX: 0, y: 0)
                        }
                        guard let removeCard = self.cardStacks[number-1].removeOne() else { return }
                        guard let removeCardView = self.cardStacksView?.removeCardView(at: number-1) else { return }
                        if !self.cardStacks[number-1].isEmpty() { self.cardStacksView?.turnLastCard(at: number-1, stackModel: self.cardStacks[number-1]) }
                        self.spaceCardStacks[index].add(removeCard)
                        self.spacesView?.addCardView(at: index, view: removeCardView)
                    })
                    return true
                }) { break }
            }
        }
            
    }
    
    private func animateStackToStack(from number: Int, _ cardOnTop: Card) {
        for index in 0..<cardStacks.count {
            if !cardStacks[index].isEmpty() {
                if cardStacks[index].accessLastCard(form: { topCard in
                    guard cardOnTop !== topCard else { return false }
                    guard cardOnTop.number.rawValue+1 == topCard.number.rawValue else { return false }
                    guard cardOnTop == topCard else { return false }
                    UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
                        self.cardStacksView?.accessTopView(at: number-1) { topView in
                            let distanceX = CGFloat((number-1-index)*Sizes.cardWitdh + (number-1-index)*5)
                            var distanceY = CGFloat(self.cardStacks[number-1].count() - self.cardStacks[index].count())
                            if distanceY == 0 { distanceY = -(distanceY+1) * CGFloat(Sizes.stackCardsSpace) }
                            else { distanceY = (distanceY-1) * CGFloat(Sizes.stackCardsSpace) }
                            topView.transform = CGAffineTransform(translationX: -distanceX, y: -distanceY)
                        }
                    }, completion: { isAnimate in
                        guard isAnimate else { return }
                        self.cardStacksView?.accessTopView(at: number-1) { topView in
                            topView.transform = CGAffineTransform(translationX: 0, y: 0)
                        }
                        guard let removeCard = self.cardStacks[number-1].removeOne() else { return }
                        guard let removeCardView = self.cardStacksView?.removeCardView(at: number-1) else { return }
                        if !self.cardStacks[number-1].isEmpty() { self.cardStacksView?.turnLastCard(at: number-1, stackModel: self.cardStacks[number-1]) }
                        self.cardStacks[index].add(removeCard)
                        self.cardStacksView?.addCardView(at: index, view: removeCardView)
                    })
                    return true
                }) { break }
            }
        }
    }
}

extension ViewController {
    @objc func baganDrag(_ notification: NSNotification) {
        guard let touch = notification.userInfo?["beganPoint"] as? UITouch else { return }
        pastPoint = touch.location(in: self.view)
        
        let tappedView: TappedCard = searchTappedCardView(touched: pastPoint!)
        switch tappedView {
        case .reversed: return
        case .stack(let number):
            startTouchStackNumber = number
            cardStacksView?.accessStackView(at: number-1) { cardViews in
                guard let pastPoint = self.pastPoint else { return }
                for index in 0..<cardViews.count-1 {
                    if pastPoint.y >= CGFloat(Sizes.viewSecondY) + CGFloat(Sizes.stackCardsSpace*index) &&
                        pastPoint.y < CGFloat(Sizes.viewSecondY) + CGFloat(Sizes.stackCardsSpace*(index+1)) {
                        startTouchDepth = index
                        break
                    }
                }
                if startTouchDepth == nil { startTouchDepth = cardViews.count-1 }
            }
        }
    }
    
    @objc func excuteWhenDrag(_ notification: NSNotification) {
        guard let touch = notification.userInfo?["touchPoint"] as? UITouch else { return }
        let touchPoint = touch.location(in: self.view)
        guard touchPoint.y > CGFloat(Sizes.viewSecondY) else { return }
        let currentX = touchPoint.x
        let currentY = touchPoint.y
        
        guard let touchStackNumber = self.startTouchStackNumber else { return }
        guard let touchDepth = self.startTouchDepth else { return }
        guard let pastPoint = self.pastPoint else { return }
        let distanceX = currentX - pastPoint.x
        let distanceY = currentY - pastPoint.y

        cardStacksView?.accessStackView(at: touchStackNumber-1) { cardViews in
            for index in touchDepth..<cardViews.count { cardViews[index].transform = CGAffineTransform(translationX: distanceX, y: distanceY) }
        }
    }
    
    @objc func endDrag(_ notification: NSNotification) {
        guard let touchEnded = notification.userInfo?["endedPoint"] as? UITouch else { return }
        let touchEndedPoint = touchEnded.location(in: self.view)
        let tappedView = searchTappedCardView(touched: touchEndedPoint)
        guard let startTouchStackNumber = self.startTouchStackNumber else { return }
        guard let startTouchDepth = self.startTouchDepth else { return }
        
        switch tappedView {
        case .reversed: resetView(startTouchStackNumber, startTouchDepth)
        case .stack(let number):
            checkWhenEndDrag(at: number, startTouchStackNumber, startTouchDepth)
        }
        
        self.startTouchDepth = nil
    }
    
    private func checkWhenEndDrag(at destStackNumber: Int, _ startTouchStackNumber: Int, _ startTouchDepth: Int) {
        cardStacks[startTouchStackNumber-1].accessCard { cards in
            if cards[startTouchDepth].number == .thirteen && cardStacks[destStackNumber-1].isEmpty() { moveCardStack(to: destStackNumber) }
            else if !cardStacks[destStackNumber-1].isEmpty() &&
                cards[startTouchDepth] == cardStacks[destStackNumber-1].getLast() &&
                cards[startTouchDepth].number.rawValue+1 == cardStacks[destStackNumber-1].getLast().number.rawValue {
                moveCardStack(to: destStackNumber)
            }
            else { resetView(startTouchStackNumber, startTouchDepth) }
        }
    }
    
    private func moveCardStack(to destIndex: Int) {
        guard let startTouchStackNumber = self.startTouchStackNumber else { return }
        guard let startTouchDepth = self.startTouchDepth else { return }
        
        var removeCards: [Card] = []
        var removeCardViews: [CardView] = []
        for _ in startTouchDepth..<cardStacks[startTouchStackNumber-1].count() {
            guard let removeCard = cardStacks[startTouchStackNumber-1].removeOne() else { return }
            guard let removeCardView = cardStacksView?.removeCardView(at: startTouchStackNumber-1) else { return }
            removeCardView.transform = CGAffineTransform(translationX: 0, y: 0)
            removeCards.append(removeCard)
            removeCardViews.append(removeCardView)
        }
        
        for index in stride(from: removeCardViews.count-1, through: 0, by: -1) {
            cardStacks[destIndex-1].add(removeCards[index])
            cardStacksView?.addCardView(at: destIndex-1, view: removeCardViews[index])
        }
        removeCards.removeAll()
        removeCardViews.removeAll()

        if !cardStacks[startTouchStackNumber-1].isEmpty() { self.cardStacksView?.turnLastCard(at: startTouchStackNumber-1, stackModel: self.cardStacks[startTouchStackNumber-1]) }
    }
    
    private func resetView(_ touchStackNumber: Int, _ touchDepth: Int) {
        cardStacksView?.accessStackView(at: touchStackNumber-1) { cardViews in
            for index in touchDepth..<cardViews.count { cardViews[index].transform = CGAffineTransform(translationX: 0, y: 0) }
        }
    }
}

