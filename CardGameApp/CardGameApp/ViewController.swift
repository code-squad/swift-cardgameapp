//
//  ViewController.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 1. 28..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    //MARK: IBOutlet
    
    @IBOutlet weak var pileStackView: BackPositionStackView!
    @IBOutlet weak var previewStackView: PositionStackView!
    @IBOutlet weak var goalsStackView: UIStackView!
    @IBOutlet weak var columnsStackView: UIStackView!
    
    //MARK: Instance
    
    private var pile = Pile()
    private var preview = Preview()
    private var goals = Goals()
    private var columns = Columns()
    
    //MARK: - Methods
    //MARK: Setting
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let image = UIImage(named: "bg_pattern") else { return }
        self.view.backgroundColor = UIColor(patternImage: image)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updatePileStackView),
                                               name: .cardStackDidChange,
                                               object: self.pile)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updatePreviewStackView),
                                               name: .cardStackDidChange,
                                               object: self.preview)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateColumnsStackView),
                                               name: .columnDidChange,
                                               object: nil)
        
        self.setUp()
    }
    
    //MARK: Notification
    
    @objc private func updatePileStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let cards = userInfo[UserInfoKey.cards] as? [Card] else { return }
        
        self.pileStackView.update(cards: cards)
    }
    
    @objc private func updatePreviewStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let cards = userInfo[UserInfoKey.cards] as? [Card] else { return }
        
        self.previewStackView.update(cards: cards)
    }
    
    @objc private func updateColumnsStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let cards = userInfo[UserInfoKey.cards] as? [Card],
            let sender = noti.object as? CardStack,
            let position = columns.position(of: sender),
            let stackView = columnsStackView.arrangedSubviews[position] as? CardGameStackView & UIStackView else { return }

        stackView.update(cards: cards)
    }
    
    //MARK: IBAction
    
    @IBAction func tapPileStackView(_ sender: Any) {
        guard let card = self.pile.pop() else { return }
        self.preview.push(card: card)
    }
    
    //MARK: Motion
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            goals.emptyAll()
            preview.empty()
            pile.empty()
            columns.emptyAll()
            
            setUp()
        }
    }
    
    //MARK: Private
    
   private func setUp() {
        var deck = Deck()
        deck.shuffle()
        
        let rangeOfStack = 1...7
        for few in rangeOfStack {
            let stack = deck.draw(few: few)
            let position = few - 1
            self.columns.add(stack: stack, to: position)
        }
        
        let stack = deck.remainingCards()
        self.pile.put(stack: stack)
    }
}

extension UIStackView {
    
    func addTagToArrangedSubviews(_ superTag: Int) {
        for index in arrangedSubviews.startIndex..<arrangedSubviews.endIndex {
            let position = index + 1
            arrangedSubviews[index].tag = superTag + position
        }
    }
}

protocol CardGameStackView {
    func add(cards: [Card])
}

extension CardGameStackView where Self: UIStackView {
    
    private func removeAllSubviews() {
        for subview in self.arrangedSubviews {
            subview.removeFromSuperview()
        }
    }
    
    func update(cards: [Card]) {
        removeAllSubviews()
        add(cards: cards)
    }
}
