//
//  ViewController.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 12..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var cardGameManager: CardGameManageable = CardGameDelegate.shared()

    private var deckView: CardDeckView!
    private var stackView: CardStacksView!
    private var foundationView: FoundationView!

    static let spaceY: CGFloat = 15.0
    static let widthDivider: CGFloat = 8
    static let cardHeightRatio: CGFloat = 1.27
    static let cardSize = CGSize(width: 414 / ViewController.widthDivider,
                                 height: (414 / ViewController.widthDivider) * ViewController.cardHeightRatio)

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialView()
    }

    private func initialView() {
        newFoundation()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_pattern")!)
        newDeck()
        newStacks()
        setNotification()
    }

    private func setNotification() {
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(updateFoundations),
//                                               name: .foundationUpdated,
//                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateDeck),
                                               name: .deckUpdated,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateOpenDeck(notification: )),
                                               name: .openDeckUpdated,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(deckViewDidDoubleTap(notification:)),
                                               name: .doubleTappedOpenedDeck,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(stackViewDidDoubleTap(notification:)),
                                               name: .doubleTappedStack,
                                               object: nil)
    }

    // MARK: ChangedView Related

    @objc func updateFoundations() {
        self.foundationView.redraw()
    }

    @objc func updateDeck() {
        self.deckView.redraw()
    }

    @objc func updateStack(notification: Notification) {
        guard let number = notification.object else { return }
        guard let column = number as? Int else { return }
        self.stackView.redraw(column: column)
    }

    @objc func updateOpenDeck(notification: Notification) {
        guard notification.object as! Bool else {
            self.deckView.drawRefresh()
            return
        }
        self.deckView.drawOpenDeck()
    }

    // MARK: InitialView Related

    private func newDeck() {
        self.deckView = CardDeckView()
        self.view.addSubview(deckView)
        deckView.drawDefault()
    }

    private func newFoundation() {
        self.foundationView = FoundationView()
        self.view.addSubview(foundationView)
        foundationView.drawDefault()
    }

    private func newStacks() {
        self.stackView = CardStacksView()
        self.view.addSubview(stackView)
        stackView.newDraw()
    }
    
    // MARK: Shake motion Related

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            self.cardGameManager.shuffleDeck()
        }
    }

    // MARK: Animation Related

    // from deck view to foundation || stack view
    @objc func deckViewDidDoubleTap(notification: Notification) {
        guard let userInfo = notification.userInfo else {return}
        guard let from = userInfo["from"] else { return }

        if let fromView = from as? CardDeckView {
            let targetCard = deckView.lastCardView!

            let result = cardGameManager.movableFromDeck(from: .deck)
            let toView = result.to
            guard let toIndex = result.index else { return } // toIndex가 옵셔널이 풀리면서 이미 룰 체크 완료

            let fromFrame = frameCalculator(view: .deck, index: 0)

            let toFrame = frameCalculator(view: toView, index: toIndex)
            let moveTo = (x: toFrame.x - fromFrame.x,
                          y: toFrame.y - fromFrame.y)
            // 모델변화
            let popCard = cardGameManager.getDeckDelegate().lastOpenedCard()!
            if toView == .foundation {
                cardGameManager.getFoundationDelegate().newStackUp(newCard: popCard, column: toIndex)
            }
            if toView == .stack {
                cardGameManager.getWholeStackDelegate().newStackUp(newCard: popCard, column: toIndex)
            }
            cardGameManager.popOpenDeck() // deck의 마지막카드 제거
            UIView.animate(
                withDuration: 1.0,
                animations: {
                    targetCard.layer.zPosition = 1
                    targetCard.frame.origin.x += moveTo.x
                    targetCard.frame.origin.y += moveTo.y
            },
                completion: { _ in
                    self.foundationView.redraw()
                    self.deckView.redraw()
                    self.stackView.redraw(column: toIndex)
                    targetCard.removeFromSuperview()
            })
        } else {
            return
        }
    }

    @objc func stackViewDidDoubleTap(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let from = userInfo["from"] else { return }

        if let fromView = from as? OneStack {
            let fromIndex = fromView.column!
            let targetCard = fromView.lastCardView!

            let result = cardGameManager.movableFromStack(from: .fromStack, column: fromIndex)
            let toView = result.to
            guard let toIndex = result.index else { return }

            let fromFrame = frameCalculator(view: .fromStack, index: fromIndex)
            let toFrame = frameCalculator(view: toView, index: toIndex)

            let moveTo = (x: toFrame.x - fromFrame.x,
                          y: toFrame.y - fromFrame.y)
            // 모델 변화(movable~ 메소드로 이미 룰 체킹됨)
            let popCard = cardGameManager.getWholeStackDelegate().getStackDelegate(of: fromIndex).currentLastCard()
            cardGameManager.getWholeStackDelegate().getStackDelegate(of: fromIndex).removePoppedCard() //stack의 마지막카드제거
            if toView == .foundation {
                cardGameManager.getFoundationDelegate().newStackUp(newCard: popCard, column: toIndex)
            }
            if toView == .stack {
                cardGameManager.getWholeStackDelegate().newStackUp(newCard: popCard, column: toIndex)
            }


            UIView.animate(
                withDuration: 1.0,
                animations: {
                    targetCard.layer.zPosition = 1
                    targetCard.frame.origin.x += moveTo.x
                    targetCard.frame.origin.y += moveTo.y
                },
                completion: { _ in
                    targetCard.removeFromSuperview()
                    self.foundationView.redraw()
                    self.deckView.redraw()
                    self.stackView.redraw(column: fromIndex)
                    self.stackView.redraw(column: toIndex)
                })
        } else {
            return
        }
    }

    private func frameCalculator(view: ViewKey, index: Int) -> CGPoint {
        switch view {
        case .foundation:
            return CGPoint(x: PositionX.allValues[index].value,
                           y: PositionY.upper.value)
        case .fromStack:
            let newY = PositionY.bottom.value + (ViewController.spaceY * CGFloat(cardGameManager.getWholeStackDelegate().getStackDelegate(of: index).countOfCard()-1))
            return CGPoint(x: PositionX.allValues[index].value,
                           y: newY)

        case .stack:
            let newY = PositionY.bottom.value + (ViewController.spaceY * CGFloat(cardGameManager.getWholeStackDelegate().getStackDelegate(of: index).countOfCard()))
            return CGPoint(x: PositionX.allValues[index].value,
                           y: newY)

        case .deck:
            return CGPoint(x: PositionX.sixth.value,
                            y: PositionY.upper.value)
        }
    }

}


