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
                                               selector: #selector(updatePileStackView),
                                               name: .pileDidChange,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updatePreviewStackView),
                                               name: .previewDidChange,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateColumnsStackView),
                                               name: .columnDidChange,
                                               object: nil)
        
        klondike.setUp()
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
            let sender = noti.object as? Column,
            let position = klondike.position(of: sender),
            let stackView = columnsStackView.arrangedSubviews[position] as? CardGameStackView & UIStackView else { return }

        stackView.update(cards: cards)
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
