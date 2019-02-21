//
//  SpaceView.swift
//  CardGameApp
//
//  Created by 윤동민 on 21/02/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

class SpaceView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetting()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetting()
    }
    
    private func initialSetting() {
        self.backgroundColor = UIColor.clear
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 7
        self.clipsToBounds = false
    }
    
    func clearView() {
        
    }
}
