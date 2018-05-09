//
//  ViewController.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 12..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var cardGameManager: CardGameManageable!

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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateFoundations),
                                               name: .foundationUpdated,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateDeck),
                                               name: .deckUpdated,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateDeck),
                                               name: .stackUpdated,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateOpenDeck(notification: )),
                                               name: .openDeckUpdated,
                                               object: nil)
    }

    // MARK: ChangedView Related

    @objc func updateFoundations() {
        self.foundationView.redraw()
    }

    @objc func updateDeck() {
        self.deckView.redraw()
    }

    @objc func updateStack() {
        self.stackView.redraw()
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
            view.subviews.forEach() { $0.removeFromSuperview() }
            self.cardGameManager = CardGameDelegate.restartSharedDeck()
            self.initialView()
        }
    }


}


