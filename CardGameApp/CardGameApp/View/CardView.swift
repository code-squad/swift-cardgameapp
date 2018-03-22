//
//  CardView.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 11..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class CardView: UIImageView {
    private(set) var viewModel: CardViewModel? {
        didSet {
            self.image = viewModel?.image
            registerGesture()
        }
    }
    private var borderState: BorderState = .show

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = clipToBounds
        self.sendBack()
    }

    func bringFront() {
        self.layer.zPosition = .infinity
    }

    func sendBack() {
        self.layer.zPosition = 1
    }

    convenience init(viewModel: CardViewModel, size: CGSize) {
        self.init(image: viewModel.image, faceState: viewModel.faceState, size: size, borderState: viewModel.borderState)
        self.viewModel = viewModel
        registerGesture()
    }

    private func registerGesture() {
        guard let viewModel = viewModel else { return }
        // 현재 카드 위치에 따라 다른 제스처 등록.
        switch viewModel.location {
        case .spare: registerTapGesture(tapCount: 1)
        default: registerTapGesture(tapCount: 2)
        }
    }

    convenience init(frame: CGRect, borderState: BorderState) {
        self.init(frame: frame)
        setSizeTo(frame.size)
        setDefaultBorderStyle(borderState: borderState)
        self.borderState = borderState
    }

    convenience init(size: CGSize, borderState: BorderState) {
        self.init(frame: CGRect(origin: .zero, size: size), borderState: borderState)
    }

    convenience init(image: UIImage, faceState: FaceState, size: CGSize, borderState: BorderState) {
        self.init(size: size, borderState: borderState)
        self.image = image
    }

    convenience init() {
        self.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setBorderState(to borderState: BorderState) {
        self.borderState = borderState
    }

    func setViewModel(_ viewModel: CardViewModel) {
        self.viewModel = viewModel
        self.image = viewModel.image
    }

    func setImage(_ image: UIImage) {
        self.image = image
    }

    func removeImage() {
        self.image = nil
    }

}

extension CardView {
    private func registerTapGesture(tapCount: Int) {
        self.isUserInteractionEnabled = true
        let selector = (tapCount == 1) ? #selector(handleSingleTap(sender:)) : #selector(handleDoubleTap(sender:))
        let recognizer = UITapGestureRecognizer(target: self, action: selector)
        recognizer.numberOfTapsRequired = tapCount
        self.addGestureRecognizer(recognizer)
    }

    @objc func handleSingleTap(sender: UITapGestureRecognizer) {
        handleCertainView { gameView in
            gameView.handleSingleTapOnSpare()
        }
    }

    @objc func handleDoubleTap(sender: UITapGestureRecognizer) {
        // 앞면인 경우에만 터치 동작.
        guard self.viewModel?.faceState == FaceState.up else { return }
        handleCertainView { gameView in
            gameView.handleDoubleTapOnCard(tappedView: self, recognizer: sender)
        }
    }

    private func handleCertainView(execute: (GameView) -> Void) {
        // GameView까지 올라가서 핸들러 작동.
        var nextResponder = self.next
        while nextResponder != nil {
            if let gameView = nextResponder as? GameView {
                execute(gameView)
            }
            nextResponder = nextResponder?.next
        }
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
