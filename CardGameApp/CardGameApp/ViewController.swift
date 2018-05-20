//
//  ViewController.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 12..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var cardGameDelegate: CardGameDelegate = CardGameManager.shared()

    private var deckView: CardDeckView!
    private var stackView: CardStacksView!
    private var foundationView: FoundationView!

    static let widthOfRootView: CGFloat = 414
    static let heightOfRootView: CGFloat = 736
    static let spaceY: CGFloat = 15.0
    static let widthDivider: CGFloat = 8
    static let cardHeightRatio: CGFloat = 1.27
    static let cardSize = CGSize(width: widthOfRootView / widthDivider,
                                 height: (widthOfRootView / widthDivider) * cardHeightRatio)

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialView()
    }

    private func initialView() {
        setFoundationView()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_pattern")!)
        setDeckView()
        setStacksView()
        setNotification()
    }

    private func setNotification() {
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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(dragAction(notification:)),
                                               name: .cardDragged,
                                               object: nil)

    }

    // MARK: ChangedView Related

    @objc func updateDeck() {
        self.deckView.reload()
    }

    @objc func updateOpenDeck(notification: Notification) {
        guard notification.object as! Bool else {
            self.deckView.loadRefreshIcon()
            return
        }
        self.deckView.setOpenDeck()
    }

    // MARK: InitialView Related

    private func setDeckView() {
        self.deckView = CardDeckView()
        self.view.addSubview(deckView)
        deckView.setup()
    }

    private func setFoundationView() {
        self.foundationView = FoundationView()
        self.view.addSubview(foundationView)
        foundationView.setup()
    }

    private func setStacksView() {
        self.stackView = CardStacksView()
        self.view.addSubview(stackView)
        stackView.setup()
    }
    
    // MARK: Shake motion Related

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            self.cardGameDelegate.shuffleDeck()
        } // 모델 변경
        self.deckView.resetByShake()
    }

    // MARK: Animation Related

    // from deck view to foundation || stack view
    @objc func deckViewDidDoubleTap(notification: Notification) {
        guard let userInfo = notification.userInfo else {return}
        guard let from = userInfo[Key.FromView] else { return }
        guard (from as? CardDeckView) != nil else { return }
        let targetCard = deckView.lastCardView!

        let result = cardGameDelegate.movableFromDeck(from: .deck)
        let toView = result.to
        guard let toIndex = result.index else { return } // toIndex가 옵셔널이 풀리면서 이미 룰 체크 완료

        let fromFrame = frameCalculator(view: .deck, index: 0)

        let toFrame = frameCalculator(view: toView, index: toIndex)
        let moveTo = (x: toFrame.x - fromFrame.x,
                      y: toFrame.y - fromFrame.y)

        let popCard = cardGameDelegate.getDeckDelegate().lastOpenedCard()!
        if toView == .foundation {
            let foundationManager: Stackable = cardGameDelegate.getFoundationDelegate() as Stackable
            foundationManager.stackUp(newCard: popCard, newCards: nil, column: toIndex)
        }
        if toView == .stack {
            cardGameDelegate.getWholeStackDelegate().stackUp(newCard: popCard, newCards: nil, column: toIndex)
        }
        cardGameDelegate.popOpenDeck() // deck의 마지막카드 제거
        UIView.animate(
            withDuration: 1.0,
            animations: {
                targetCard.layer.zPosition = 1
                targetCard.frame.origin.x += moveTo.x
                targetCard.frame.origin.y += moveTo.y
        },
            completion: { _ in
                targetCard.removeFromSuperview()
                self.foundationView.reload()
                self.deckView.reload()
                self.stackView.reload(column: toIndex)
        })

    }

    @objc func stackViewDidDoubleTap(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let from = userInfo[Key.FromView] else { return }
        guard let fromView = from as? OneStack else { return }
        let fromIndex = fromView.getColumn()
        let targetCard = fromView.lastCardView!

        let result = cardGameDelegate.movableFromStack(from: .fromStack, column: fromIndex)
        let toView = result.to
        guard let toIndex = result.index else { return }

        let fromFrame = frameCalculator(view: .fromStack, index: fromIndex)
        let toFrame = frameCalculator(view: toView, index: toIndex)

        let moveTo = (x: toFrame.x - fromFrame.x,
                      y: toFrame.y - fromFrame.y)

        let popCard = cardGameDelegate.getWholeStackDelegate().getStackDelegate(of: fromIndex).currentLastCard()
        cardGameDelegate.getWholeStackDelegate().getStackDelegate(of: fromIndex).removePoppedCard() //stack의 마지막카드제거

        if toView == .foundation {
            let foundationManager: Stackable = cardGameDelegate.getFoundationDelegate() as Stackable
            foundationManager.stackUp(newCard: popCard, newCards: nil, column: toIndex)
        }

        if toView == .stack {
            let stacksManger: Stackable = cardGameDelegate.getWholeStackDelegate() as Stackable
            stacksManger.stackUp(newCard: popCard, newCards: nil, column: toIndex)
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
                self.foundationView.reload()
                self.deckView.reload()
                self.stackView.reload(column: fromIndex)
                self.stackView.reload(column: toIndex)
        })
    }

    private func frameCalculator(view: ViewKey, index: Int) -> CGPoint {
        switch view {
        case .foundation:
            return CGPoint(x: PositionX.allValues[index].value,
                           y: PositionY.upper.value)
        case .fromStack:
            let newY = PositionY.bottom.value + (ViewController.spaceY * CGFloat(cardGameDelegate.getWholeStackDelegate().getStackDelegate(of: index).countOfCard()-1))
            return CGPoint(x: PositionX.allValues[index].value,
                           y: newY)

        case .stack:
            let newY = PositionY.bottom.value + (ViewController.spaceY * CGFloat(cardGameDelegate.getWholeStackDelegate().getStackDelegate(of: index).countOfCard()))
            return CGPoint(x: PositionX.allValues[index].value,
                           y: newY)

        case .deck:
            return CGPoint(x: PositionX.sixth.value,
                            y: PositionY.upper.value)
        }
    }

    var movableViews: [CardImageView]!
    var currentFrames = CGPoint(x: 0.0, y:0.0)
    var originalInfo: MoveInfo!
    var toFrame: CGPoint!
    var toInfo: MoveInfo!

}

// MARK: Drag Action Related

extension ViewController {

    @objc func dragAction(notification: Notification) {
        guard let object = notification.object else {return}
        guard let cardView = object as? CardImageView else {return}
        guard let superView = cardView.superview else {return}
        guard let userInfo = notification.userInfo else {return}
        guard let sender = userInfo[Key.GestureRecognizer] else {return}
        guard let recognizer = sender as? UIPanGestureRecognizer else {return}
        let translation = recognizer.translation(in: view)

        switch recognizer.state {
        case .began:
            originalInfo = FrameCalculator().originalLocation(view: superView, position: cardView.frame.origin)
            movableViews = originalInfo.getView().cardImages(at: originalInfo.getIndex())
        case .changed:
            movableViews.forEach{
                $0.layer.zPosition = 1
                $0.frame.origin = CGPoint(x: $0.frame.origin.x + translation.x,
                                          y: $0.frame.origin.y + translation.y)
                currentFrames = $0.frame.origin
            }
            recognizer.setTranslation(CGPoint.zero, in: view)
        case .ended:
            // currentFrame을 rootView기준으로 변환
            currentFrames = FrameCalculator().convertToRootView(from: originalInfo, origin: self.currentFrames)
            toInfo = self.toInfo(at: currentFrames)
            guard cardGameDelegate.ruleCheck(fromInfo: originalInfo, toInfo: toInfo) else {return}
            toFrame = FrameCalculator().availableFrame(of: toInfo)
            let moveTo = (x: toFrame.x - currentFrames.x,
                          y: toFrame.y - currentFrames.y)

            UIView.animate(
                withDuration: 0.5,
                animations: {
                    self.movableViews.forEach {
                        $0.layer.zPosition = 1
                        $0.frame.origin.x += moveTo.x
                        $0.frame.origin.y += moveTo.y
                    }
            },
                completion: { _ in
                    self.reloadViews()
            })
        case .cancelled: return
        default: return
        }

    }

    // 현재 currentFrame이 위치한 뷰에 맞는 MoveInfo 생성
    func toInfo(at point: CGPoint) -> MoveInfo? {
        guard let to = FrameCalculator().toInfo(at: point) else {return nil}

        switch to.view {
        case .foundation:
            return MoveInfo(view: foundationView as Movable, column: to.column!, index: nil)
        case .stack:
            return MoveInfo(view: stackView.getOneStack(of: to.column!), column: to.column!, index: nil)
        default: break
        }

        return nil
    }

    func isInside(point: CGPoint) -> Bool {
        if self.foundationView.contains(point: point) {
            return true
        } else if self.stackView.isContains(point: point) {
            return true
        } else {
            return false
        }
    }

    // model업데이트 후에 해당하는 뷰 reload
    private func reloadViews() {
        let from = self.originalInfo.getView().convertViewKey()
        let to = self.toInfo.getView().convertViewKey()

        switch from {
        case .deck: self.deckView.reload()
        case .stack: self.stackView.reload(column: self.originalInfo.getColumn()!)
        default: return
        }

        switch to {
        case .stack: self.stackView.reload(column: self.toInfo.getColumn()!)
        case .foundation: self.foundationView.reload()
        default: return
        }
    }

}

