//
//  CardView.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 11..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class CardView: UIImageView {

    private(set) var viewModel: CardViewModel?

    convenience init(viewModel: CardViewModel, frame: CGRect) {
        self.init(frame: frame)
        self.viewModel = viewModel
        self.image = viewModel.onCurrentFace()
        registerTapGesture(tapCount: 1)
        registerTapGesture(tapCount: 2)
        viewModel.status.bind { [unowned self] _ in
            self.image = viewModel.onCurrentFace()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = clipToBounds
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func bringToFront() {
        superview?.bringSubview(toFront: self)
    }

    func sendBack() {
        superview?.sendSubview(toBack: self)
    }

    func move(toView: CanLayCards) {
        let fromView = self.superview as? CanLayCards
        fromView?.removeLastCard()
        toView.lay(card: self)
    }

}

extension CardView: CardPresentable {
    // 카드크기 일정하게 제약
    func setSizeTo(_ size: CGSize) {
        self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
    }

    // 카드 테두리 설정
    func setDefaultBorderStyle(borderState: BorderState) {
        switch borderState {
        case .show:
            self.layer.borderColor = borderColor
            self.layer.borderWidth = borderWidth
        default: break
        }
    }
}

extension CardView {

    private func registerTapGesture(tapCount: Int) {
        let selector = (tapCount == 1) ? #selector(handleSingleTap(sender:)) : #selector(handleDoubleTap(sender:))
        let recognizer = UITapGestureRecognizer(target: self, action: selector)
        recognizer.numberOfTapsRequired = tapCount
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(recognizer)
    }

    @objc func handleSingleTap(sender: UITapGestureRecognizer) {
        guard let currLocation = self.viewModel?.location.value, case Location.spare = currLocation else { return }
        handleCertainView { gameView in
            self.bringToFront()
            gameView.delegate?.onSpareViewTapped(tappedView: self)
        }
    }

    @objc func handleDoubleTap(sender: UITapGestureRecognizer) {
        guard viewModel!.isUserInteractive else { return }
        handleCertainView { gameView in
            self.bringToFront()
            gameView.delegate?.onCardViewDoubleTapped(tappedView: self)
        }
    }

    func handleCertainView(execute: (GameView) -> Void) {
        // GameView까지 올라가서 핸들러 작동
        var nextResponder = self.next
        while nextResponder != nil {
            if let gameView = nextResponder as? GameView {
                execute(gameView)
            }
            nextResponder = nextResponder?.next
        }
    }
}
