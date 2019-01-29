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
    
    var deck: Deck?
    
    //MARK: IBOutlet
    
    @IBOutlet weak var cardsStackView: UIStackView!
    
    //MARK: - Methods
    //MARK: Setting
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        guard let image = UIImage(named: "bg_pattern") else { return }
        self.view.backgroundColor = UIColor(patternImage: image)
        
        self.deck = Deck()
        self.deck?.shuffle()
        setCards()
    }
    
    //MARK: Private
    
    private func setCards() {
        
        for subview in cardsStackView.arrangedSubviews {
            guard let subImageView = subview as? UIImageView else { return }
            guard let card = self.deck?.draw(few: 1).pop() else { continue }
            subImageView.image = card.image()
        }
    }
    
    //MARK: Motion
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        super.motionEnded(motion, with: event)
        if motion == .motionShake {
            setCards()
        }
    }
    
}

extension Card {
    func image() -> UIImage? {
        let name = description
        return UIImage(named: name)
    }
}
