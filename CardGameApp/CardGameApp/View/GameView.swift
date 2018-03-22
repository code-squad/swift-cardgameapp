//
//  GameView.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 13..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class GameView: UIView {
    weak var delegate: CanHandleGesture?

    private(set) var config: ViewConfig!

    private(set) var spareView: SpareView!
    private(set) var wasteView: WasteView!
    private(set) var foundationView: FoundationView!
    private(set) var tableauViews: [TableauView] = []

    private var tableauViewContainer: UIStackView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayoutMargins()
        self.config = ViewConfig(on: self)
        spareView = SpareView(config)
        wasteView = WasteView(config, borderState: .show)
        foundationView = FoundationView(self, config)
        tableauViewContainer = UIStackView()
        setupTableauView()
        setTableauViewsInContainer()
    }

    private func setLayoutMargins() {
        self.layoutMargins = UIEdgeInsets(top: UIApplication.shared.statusBarFrame.height,
                                          left: 0,
                                          bottom: 5,
                                          right: 0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        drawBackground()
        self.addSubview(spareView)
        self.addSubview(wasteView)
        self.addSubview(foundationView)
        self.addSubview(tableauViewContainer)
    }

    private func drawBackground() {
        self.backgroundColor = UIColor(patternImage: .init(imageLiteralResourceName: config.background))
    }

    private func setupTableauView() {
        for _ in 1...GameViewModel.Settings.maxStud {
            let tableauView = TableauView(self, config)
            self.tableauViews.append(tableauView)
        }
    }

    private func setTableauViewsInContainer() {
        let size = CGSize(width: self.frame.width, height: self.frame.height-config.tableauPosition.y)
        tableauViewContainer.frame = CGRect(origin: config.tableauPosition, size: size)
        tableauViews.forEach { tableauViewContainer.addArrangedSubview($0) }
        tableauViewContainer.axis = .horizontal
        tableauViewContainer.distribution = .fillEqually
        tableauViewContainer.spacing = config.horizontalStackSpacing
    }

}

extension GameView: CanHandleGesture {
    func handleSingleTapOnSpare() {
        delegate?.handleSingleTapOnSpare()
    }

    func handleDoubleTapOnCard(tappedView: CardView, recognizer: UITapGestureRecognizer) {
        delegate?.handleDoubleTapOnCard(tappedView: tappedView, recognizer: recognizer)
    }
}
