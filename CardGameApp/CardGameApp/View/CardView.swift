//
//  CardView.swift
//  CardGameApp
//
//  Created by 윤지영 on 23/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

class CardView: UIImageView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    convenience init(frame: CGRect, viewModel: CardViewModel) {
        self.init(frame: frame)
        image = UIImage(named: viewModel.imageName)
        registerAsObserver(of: viewModel)
    }

    private func setUp() {
        roundCorners()
    }

    private func roundCorners() {
        layer.cornerRadius = 4
        layer.masksToBounds = true
    }

    private func registerAsObserver(of viewModel: CardViewModel) {
        NotificationCenter.default.addObserver(self, selector: #selector(updateImage(_:)), name: .cardDidFlip, object: viewModel)
        NotificationCenter.default.addObserver(self, selector: #selector(updateImage(_:)), name: .cardDidReset, object: viewModel)
    }

    @objc private func updateImage(_ notification: Notification) {
        if let imageName = notification.userInfo?[Notification.InfoKey.imageNameOfCard] as? String {
            image = UIImage(named: imageName)
        }
    }

}
