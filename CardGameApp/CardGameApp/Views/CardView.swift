//
//  CardView.swift
//  CardGameApp
//
//  Created by 윤동민 on 20/02/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

extension NSNotification.Name {
    static let createdCardView = NSNotification.Name(rawValue: "createdCardView")
}

class CardView: UIImageView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setCardImage(name: String) {
        self.image = UIImage(named: name)
        NotificationCenter.default.post(name: .createdCardView, object: nil, userInfo: ["card" : self])
    }
    
    func setBackImage() {
        self.image = UIImage(named: "card-back")
        removeRecognizer()
    }
    
    private func removeRecognizer() {
        guard let recognizers = self.gestureRecognizers else { return }
        for recognizer in recognizers { self.removeGestureRecognizer(recognizer) }
    }
}

