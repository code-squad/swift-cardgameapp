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
    
    @IBOutlet weak var pileStackView: PileStackView!
    
    //MARK: - Properties
    
    lazy var klondike: Klondike = {
    
        return Klondike()
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
                                               selector: #selector(updatePileStackView),
                                               name: .cardStackDidChange,
                                               object: nil)
        klondike.start()
    }
    
    //MARK: Private

    @objc private func updatePileStackView(_ noti: Notification) {
        
        guard let userInfo = noti.userInfo,
              let pileStack = userInfo[UserInfoKey.cardStack] as? CardStack else { return }

        pileStackView.add(cardStack: pileStack)
    }
    
    //MARK: Motion
}
