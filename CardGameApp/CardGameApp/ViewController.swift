//
//  ViewController.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 1. 26..
//  Copyright © 2018년 Napster. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var deck: Deck!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeBackGround()
        self.deck = Deck()
        self.deck.shuffle()
        makeCards()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func makeCards() {
        let screenWidth = UIScreen.main.fixedCoordinateSpace.bounds.width
        guard let stack = try? self.deck.makeStack(numberOfCards: 7) else { return }
        for index in 0..<stack.count {
            let card = stack[index].getImageCard()
            card.makeCardView(screenWidth: screenWidth, index: index, yCoordinate: 100)
            self.view.addSubview(card)
        }
    }
    
    private func makeBackGround() {
        guard let tableBackground = UIImage(named: "cg_background") else { return }
        self.view.backgroundColor = UIColor(patternImage: tableBackground)
    }
}
