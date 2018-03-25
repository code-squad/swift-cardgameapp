//
//  TableauViewContainer.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 3. 23..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class TableauViewContainer: UIView {
    private var tableauViews: [TableauView] = []
    private var config: ViewConfig

    convenience init(frame: CGRect, config: ViewConfig) {
        self.init(frame: frame)
        self.config = config
        configureTableauViews()
    }

    override init(frame: CGRect) {
        config = ViewConfig(on: UIView())
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        config = ViewConfig(on: UIView())
        super.init(coder: aDecoder)
    }

    private func configureTableauViews() {
        (0..<config.tableauCount).forEach {
            let origin = CGPoint(x: CGFloat($0)*(config.cardSize.width+config.normalSpacing), y: 0)
            let tableauView = TableauView(
                frame: CGRect(origin: origin, size: CGSize(width: config.cardSize.width, height: frame.height)),
                index: $0, config: config)
            tableauViews.append(tableauView)
            addSubview(tableauView)
        }
    }

    func setupCards(_ viewModels: TableauViewModels, completion: @escaping (CardView) -> Void) {
        for (view, viewModel) in zip(tableauViews, viewModels) {
            view.reset()
            viewModel.cardViewModels.enumerated().forEach { (index, viewModel) in
                let origin = CGPoint(x: view.frame.origin.x,
                                     y: frame.origin.y+CGFloat(index)*(config.cardSize.height * 0.3))
                let cardFrame = CGRect(origin: origin, size: config.cardSize)
                let cardView = CardView(viewModel: viewModel, frame: cardFrame)
                view.lay(card: cardView)
                completion(cardView)
            }
        }
    }

    func removeAllCards() {
        tableauViews.forEach { $0.removeAllSubviews() }
    }

    func at(_ index: Int) -> TableauView {
        return tableauViews[index]
    }

}
