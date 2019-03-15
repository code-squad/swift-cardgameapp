//
//  CardView.swift
//  CardGameApp
//
//  Created by 윤동민 on 20/02/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

extension NSNotification.Name {
    static let tappedCardView = NSNotification.Name(rawValue: "TappedCardView")
}

class CardView: UIImageView {
    private var recog: UITapGestureRecognizer?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createRecognizer()
        self.addGestureRecognizer(recog!)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createRecognizer()
        self.addGestureRecognizer(recog!)
    }
    
    private func createRecognizer() {
        recog = UITapGestureRecognizer(target: self, action: #selector(tappedCardView(_:)))
        recog?.numberOfTapsRequired = 2
    }
    
    func setCardImage(name: String) {
        self.image = UIImage(named: name)
        self.isUserInteractionEnabled = true
    }
    
    @objc func tappedCardView(_ recognizer: UITapGestureRecognizer) {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        NotificationCenter.default.post(name: .tappedCardView, object: nil, userInfo: ["touchedPoint": recognizer.location(in: rootViewController.view)])
    }
    
    func setBackImage() {
        self.image = UIImage(named: "card-back")
        self.isUserInteractionEnabled = false
    }
}

