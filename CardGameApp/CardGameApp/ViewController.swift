//
//  ViewController.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 1. 26..
//  Copyright © 2018년 Napster. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeBackGround()
        for index in 0..<7 {
            makeCards(index: index)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func makeCards(index: Int) {
        let screenWidth = UIScreen.main.fixedCoordinateSpace.bounds.width
        let card = UIImageView(image: UIImage(named: "card_back"))
        card.makeCardView(screenWidth: screenWidth, index: index)
        self.view.addSubview(card)
    }
    
    private func makeBackGround() {
        guard let tableBackground = UIImage(named: "cg_background") else { return }
        self.view.backgroundColor = UIColor(patternImage: tableBackground)
    }
}
