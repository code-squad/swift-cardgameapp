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
    
    var klondike: Klondike = Klondike()
    
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
        klondike.setUp()
    }
    
    //MARK: Private
    
    @objc private func updatePileStackView(_ noti: Notification) {
        
        guard let userInfo = noti.userInfo,
            let cards = userInfo[UserInfoKey.cards] as? [Card],
            let stackType = userInfo[UserInfoKey.stackType] as? CardStackType else { return }
        
        switch stackType {
        case .pile:
            pileStackView.removeAllSubviews()
            pileStackView.add(cards: cards)
        case .preview:
            previewStackView.removeAllSubviews()
            previewStackView.add(cards: cards)
        case let .goals(type):
            let goalStackView = goalsStackView.arrangedSubviews[type.rawValue - 1] as? PositionStackView
            goalStackView?.removeAllSubviews()
            goalStackView?.add(cards: cards)
        case let .columns(position):
            let columnStackView = columnsStackView.arrangedSubviews[position] as? ColumnStackView
            columnStackView?.removeAllSubviews()
            columnStackView?.add(cards: cards)
        }
    }
    
    @IBAction func tapPileStackView(_ sender: Any) {
        self.klondike.flipCardsFromPileToPreview()
    }
    
    //MARK: Motion
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            klondike.reset()
        }
    }
}

extension UIStackView {
    
    func removeAllSubviews() {
        for subview in self.arrangedSubviews {
            subview.removeFromSuperview()
        }
    }
}
