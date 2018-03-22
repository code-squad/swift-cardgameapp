//
//  FoundationView.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 13..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class FoundationView: UIStackView {

    private var config: ViewConfig!

    convenience init(_ view: UIView, _ config: ViewConfig) {
        let size = CGSize(width: view.frame.width-config.cardSize.width*3, height: config.cardSize.height)
        self.init(frame: CGRect(origin: config.foundationPosition, size: size))
        self.config = config
        configure()
        setupSpaces()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    private func configure() {
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.spacing = config.horizontalStackSpacing
    }

    private func setupSpaces() {
        (0..<GameViewModel.Settings.foundationCount).forEach { _ in
            let foundationView = CardView(size: config.cardSize, borderState: .show)
            self.addArrangedSubview(foundationView)
        }
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func turnOverFrontCard(_ spaceNumber: Int) {
        (self.arrangedSubviews[spaceNumber] as? CardView)?.viewModel?.turnOver(toFace: .up)
    }
}
