//
//  ViewController.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 1. 28..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: IBOutlet
    
    @IBOutlet weak var pileStackView: PositionStackView!
    
    //MARK: - Properties
    
    lazy var klondike: Klondike = {
    
        let deck = Deck()
        let klondike = Klondike(deck: deck)
        return klondike
    }()
    

    
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
                                               selector: #selector(updateStackView),
                                               name: .cardStackDidChange,
                                               object: nil)
    }
    
    //MARK: Private

    @objc private func updateStackView(_ noti: Notification) {
        
        guard let userInfo = noti.userInfo,
              let cards = userInfo[UserInfoKey.cards] as? [Card] else { return }

        pileStackView.add(cards: cards)
    }
    
    //MARK: Motion
}
