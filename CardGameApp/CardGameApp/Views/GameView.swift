//
//  GameView.swift
//  CardGameApp
//
//  Created by yuaming on 03/04/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class GameView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        loadDefaultOptions()
    }
}

// MARK: - Private functions
private extension GameView {
    func loadDefaultOptions() {
        self.backgroundColor = UIColor(patternImage: UIImage(named: "Game")!)
    }
}
