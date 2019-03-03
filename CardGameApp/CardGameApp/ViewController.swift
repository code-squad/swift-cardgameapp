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
    private let klondike = Klondike()
    
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
                                               selector: #selector(addPileStackView),
                                               name: .pileDidAdd,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(removePileStackView),
                                               name: .pileDidPop,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addPreviewStackView),
                                               name: .previewDidAdd,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(removePreviewStackView),
                                               name: .previewDidPop,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addColumnsStackView),
                                               name: .columnDidAdd,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(removeColumnsStackView),
                                               name: .columnDidPop,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addGoalsStackView),
                                               name: .goalDidAdd,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(removeGoalsStackView),
                                               name: .goalDidPop,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(movePreviewTopCard),
                                               name: .doubleTapPreviewView,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(moveGoalTopCard),
                                               name: .doubleTapGoalView,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(moveColumn),
                                               name: .doubleTapColumnView,
                                               object: nil)
        
        klondike.setUp()
    }
    
    //MARK: Notification
    
    @objc private func addPileStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let cards = userInfo[UserInfoKey.addedCards] as? [Card] else { return }
        self.pileStackView.add(cards: cards)
    }
    
    @objc private func removePileStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let count = userInfo[UserInfoKey.countOfPoppedCards] as? Int else { return }
        self.pileStackView.remove(count: count)
    }
    
    @objc private func addPreviewStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let cards = userInfo[UserInfoKey.addedCards] as? [Card] else { return }
        self.previewStackView.add(cards: cards)
    }
    
    @objc private func removePreviewStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let count = userInfo[UserInfoKey.countOfPoppedCards] as? Int else { return }
        self.previewStackView.remove(count: count)
    }
    
    @objc private func addColumnsStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let cards = userInfo[UserInfoKey.addedCards] as? [Card],
            let sender = noti.object as? Column,
            let position = klondike.position(of: sender),
            let stackView = columnsStackView.arrangedSubviews[position] as? CardGameStackView else { return }

        stackView.add(cards: cards)
    }
    
    @objc private func removeColumnsStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let count = userInfo[UserInfoKey.countOfPoppedCards] as? Int,
            let sender = noti.object as? Column,
            let position = klondike.position(of: sender),
            let stackView = columnsStackView.arrangedSubviews[position] as? CardGameStackView else { return }
        
        stackView.remove(count: count)
    }
    
    @objc private func addGoalsStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let cards = userInfo[UserInfoKey.addedCards] as? [Card],
            let sender = noti.object as? Goal,
            let position = klondike.position(of: sender),
            let stackView = goalsStackView.arrangedSubviews[position] as? CardGameStackView else { return }
        
        stackView.add(cards: cards)
    }
    
    @objc private func removeGoalsStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let count = userInfo[UserInfoKey.countOfPoppedCards] as? Int,
            let sender = noti.object as? Goal,
            let position = klondike.position(of: sender),
            let stackView = goalsStackView.arrangedSubviews[position] as? CardGameStackView else { return }
        
        stackView.remove(count: count)
    }
    
    @objc private func movePreviewTopCard(_ noti: Notification) {
        klondike.movePreviewTopCard()
    }
    
    @objc private func moveGoalTopCard(_ noti: Notification) {
        guard let cardView = noti.object as? CardImageView,
           let position = goalsStackView.positionOfStackViewWith(cardView: cardView) else { return }
        
        klondike.moveGoalTopCard(position: position)
    }
    
    @objc private func moveColumn(_ noti: Notification) {
        guard let cardView = noti.object as? CardImageView else { return }
        
    }
    
    //MARK: IBAction
    
    @IBAction func tapPileStackView(_ sender: Any) {
        klondike.flipCardsFromThePileToPreview()
    }
    
    //MARK: Motion
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            klondike.reset()
        }
    }
}

protocol CardGameStackView {
    func add(cards: [Card])
    func remove(count: Int)
}

extension UIStackView {
    func positionOfStackViewWith(cardView: CardImageView) -> Int? {
        guard let stackViews = arrangedSubviews as? [UIStackView] else { return nil }
        return stackViews.firstIndex(where: {$0.arrangedSubviews.contains(cardView)})
    }
}
