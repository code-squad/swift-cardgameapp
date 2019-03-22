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
    static let draggingView = NSNotification.Name(rawValue: "DraggingView")
    static let beganDragView = NSNotification.Name(rawValue: "BeganDragView")
    static let endedDragView = NSNotification.Name(rawValue: "EndedDragView")
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

extension CardView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let beganPoint = touches.first else { return }
        NotificationCenter.default.post(name: .beganDragView, object: nil, userInfo: ["beganPoint": beganPoint])
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first else { return }
        NotificationCenter.default.post(name: .draggingView, object: nil, userInfo: ["touchPoint": touchPoint])
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let endedPoint = touches.first else { return }
        
        NotificationCenter.default.post(name: .endedDragView, object: nil, userInfo: ["endedPoint": endedPoint])
        super.touchesEnded(touches, with: event)
    }
}
