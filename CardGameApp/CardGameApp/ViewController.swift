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
        self.newFoundation()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_pattern")!)

        self.newDeck()
        self.newStacks()
        NotificationCenter.default.addObserver(self, selector: #selector(updateFoundations), name: .foundationUpdated, object: nil)
//        NotificationCenter.default.addObserver(self, selector: <#T##Selector#>, name: .opendeckNeedsToBeDeleted, object: nil)

    }

    // MARK: ChangedView Related
    @objc func updateFoundations() {
        print("viewController updateFoundations")
        self.foundationView.redraw()
    }

    @objc func popOpendeckCard() {
        self.deckView.removeOpenedCard()
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


