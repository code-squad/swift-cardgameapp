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
    private var game: GameViewModel!
    private var config: ViewConfig!
    private(set) var foundationViews: [EmptyView] = []
    private(set) var wasteView: EmptyView = EmptyView(frame: .zero)
    private(set) var spareView: EmptyView = EmptyView(frame: .zero)
    private(set) var tableauViews: [EmptyView] = []
    private(set) var laidCards: [CardView] = [] {
        didSet {
            laidCards.forEach { addSubview($0) }
        }
    }

    convenience init(frame: CGRect, game: GameViewModel) {
        self.init(frame: frame)
        self.game = game
        config = ViewConfig(on: self)
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
        laidCards.forEach { $0.removeFromSuperview() }
        setupCards()
    }

    func move(_ movableCard: AnimatableCard) {
        let newLocation = movableCard.endLocation
        let newPosition: CGPoint
        switch newLocation {
        case .spare: newPosition = spareView.frame.origin
        case .waste: newPosition = wasteView.frame.origin
        case .foundation(let index): newPosition = foundationViews[index].frame.origin
        case .tableau(let index):
            let basePosition = tableauViews[index].frame.origin
            let laidCardsCount = game.tableauViewModels[index].cardViewModels.count
            newPosition = CGPoint(x: basePosition.x,
                                  y: basePosition.y+CGFloat(laidCardsCount)*config.cardSize.height*0.3)
        }
        movableCard.animateToMove(to: newPosition)
    }

    // MARK: - Private

    private func find(_ cardView: CardView) -> CardView? {
        for laidCard in laidCards where cardView.viewModel?.card == laidCard.viewModel?.card {
            return laidCard
        }
        return nil
    }

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
        wasteView = EmptyView(frame: CGRect(origin: config.wasteOrigin, size: config.cardSize), hasBorder: false)
        addSubview(wasteView)
    }

    private func configureSpareView() {
        spareView = EmptyView(frame: CGRect(origin: config.spareOrigin, size: config.cardSize), hasBorder: false)
        addRefreshButton()
        addSubview(spareView)
    }

    private func addRefreshButton() {
        let refreshImageView = UIImageView(image: UIImage(imageLiteralResourceName: config.refreshFile))
        spareView.addSubview(refreshImageView)

        refreshImageView.translatesAutoresizingMaskIntoConstraints = false
        refreshImageView.widthAnchor.constraint(equalToConstant: spareView.frame.width/2).isActive = true
        refreshImageView.heightAnchor.constraint(equalToConstant: spareView.frame.height/2).isActive = true
        refreshImageView.centerXAnchor.constraint(equalTo: spareView.centerXAnchor).isActive = true
        refreshImageView.centerYAnchor.constraint(equalTo: spareView.centerYAnchor).isActive = true

        spareView.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(refreshSpare(sender:)))
        tapRecognizer.numberOfTapsRequired = 1
        spareView.addGestureRecognizer(tapRecognizer)
    }

    @objc private func refreshSpare(sender: UITapGestureRecognizer) {
        delegate?.onRefreshButtonTapped()
    }

    private func configureFoundationViews() {
        (0..<config.foundationCount).forEach {
            let origin = CGPoint(
                x: config.foundationOrigin.x+CGFloat($0)*(config.cardSize.width+config.normalSpacing),
                y: config.foundationOrigin.y)
            let foundationView = EmptyView(frame: CGRect(origin: origin, size: config.cardSize))
            foundationViews.append(foundationView)
            addSubview(foundationView)
        }
    }

    private func configureTableauViews() {
        (0..<config.tableauCount).forEach {
            let origin = CGPoint(x: config.tableauOrigin.x+CGFloat($0)*(config.cardSize.width+config.normalSpacing),
                                 y: config.tableauOrigin.y)
            let tableauView = EmptyView(frame: CGRect(origin: origin, size: config.cardSize))
            tableauViews.append(tableauView)
            addSubview(tableauView)
        }
    }

    // setup default cards on tableau and spare, using game model
    private func setupCards() {
        guard let game = game else { return }
        laidCards = []
        for (view, viewModel) in zip(tableauViews, game.tableauViewModels) {
            let position = view.frame.origin
            viewModel.cardViewModels.enumerated().forEach { (index, viewModel) in
                let origin = CGPoint(x: position.x, y: position.y + CGFloat(index) * (config.cardSize.height * 0.3))
                let cardFrame = CGRect(origin: origin, size: config.cardSize)
                let cardView = CardView(viewModel: viewModel, frame: cardFrame)
                laidCards.append(cardView)
            }
        }
        game.spareViewModel.cardViewModels.forEach {
            let origin = spareView.frame.origin
            let cardFrame = CGRect(origin: origin, size: config.cardSize)
            let cardView = CardView(viewModel: $0, frame: cardFrame)
            laidCards.append(cardView)
        }
    }

}
