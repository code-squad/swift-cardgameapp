//
//  GameView.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 13..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class GameView: UIView {
    weak var delegate: CardViewActionDelegate?
    weak var refreshDelegate: RefreshActionDelegate?
    private var game: GameViewModel!
    private var config: ViewConfig!
    private(set) var foundationViewContainer = FoundationViewContainer(frame: .zero)
    private(set) var wasteView = WasteView(frame: .zero)
    private(set) var spareView = SpareView(frame: .zero) {
        didSet {
            spareView.delegate = self
        }
    }
    private(set) var tableauViewContainer = TableauViewContainer(frame: .zero)

    convenience init(frame: CGRect, game: GameViewModel) {
        self.init(frame: frame)
        self.game = game
        self.config = ViewConfig(on: self)
    }

    private override init(frame: CGRect) {
        super.init(frame: frame)
        setLayoutMargins()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // draw background and empty spaces where cards would be laid on
    func initialize() {
        drawBackground()
        configureWasteView()
        configureSpareView()
        configureFoundationViews()
        configureTableauViews()
        setupCards()
    }

    func newGame(with viewModel: GameViewModel) {
        self.game = viewModel
        wasteView.removeAllSubviews()
        spareView.removeAllSubviews()
        foundationViewContainer.removeAllCards()
        tableauViewContainer.removeAllCards()
        setupCards()
    }

    func move(_ movableCard: AnimatableCard) {
        let newLocation = movableCard.endLocation
        let newPosition: CGPoint
        switch newLocation {
        case .spare: newPosition = spareView.nextCardPosition()
        case .waste: newPosition = wasteView.nextCardPosition()
        case .foundation(let index): newPosition = foundationViewContainer.nextCardPosition(of: index)
        case .tableau(let index): newPosition = tableauViewContainer.nextCardPosition(of: index)
        }
        movableCard.animateToMove(to: newPosition)
    }

    // MARK: - Private

    private func setLayoutMargins() {
        self.layoutMargins = UIEdgeInsets(top: UIApplication.shared.statusBarFrame.height,
                                          left: 0,
                                          bottom: 5,
                                          right: 0)
    }

    private func drawBackground() {
        self.backgroundColor = UIColor(patternImage: .init(imageLiteralResourceName: config.backgroundFile))
    }

    private func configureWasteView() {
        wasteView = WasteView(frame: CGRect(origin: config.wasteOrigin, size: config.cardSize))
        addSubview(wasteView)
    }

    private func configureSpareView() {
        spareView = SpareView(frame: CGRect(origin: config.spareOrigin, size: config.cardSize), config: config)
        addSubview(spareView)
    }

    private func configureFoundationViews() {
        foundationViewContainer = FoundationViewContainer(frame: CGRect(origin: config.foundationOrigin, size: config.cardSize),
                                                          config: config)
        addSubview(foundationViewContainer)
    }

    private func configureTableauViews() {
        tableauViewContainer = TableauViewContainer(frame: CGRect(origin: config.tableauOrigin,
                                                                  size: CGSize(width: frame.width,
                                                                               height: frame.height-wasteView.frame.height-wasteView.frame.origin.y-config.tableauOrigin.y)),
                                                    config: config)
        addSubview(tableauViewContainer)
    }

    // setup default cards on tableau and spare, using game model
    private func setupCards() {
        tableauViewContainer.setupCards(game.tableauViewModels)
        spareView.setupCards(game.spareViewModel)
    }

}

extension GameView: RefreshActionDelegate {
    // SpareView에서 올라온 델리게이트 액션을 받아 GameViewController에 넘김
    func onRefreshButtonTapped() {
        refreshDelegate?.onRefreshButtonTapped()
    }

}
