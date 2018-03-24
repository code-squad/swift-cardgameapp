//
//  SpareView.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 3. 23..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class SpareView: UIView, CanLayCards {
    weak var delegate: RefreshActionDelegate?
    private let emptyView: EmptyView
    private var laidCards: [CardView] = []

    private var config: ViewConfig

    convenience init(frame: CGRect, config: ViewConfig) {
        self.init(frame: frame)
        self.config = config
        addRefreshButton()
    }

    override init(frame: CGRect) {
        emptyView = EmptyView(frame: CGRect(origin: .zero, size: frame.size), hasBorder: false)
        config = ViewConfig(on: UIView())
        super.init(frame: frame)
        addSubview(emptyView)
    }

    required init?(coder aDecoder: NSCoder) {
        emptyView = EmptyView(frame: .zero)
        config = ViewConfig(on: UIView())
        super.init(coder: aDecoder)
    }

    func setupCards(_ viewModel: CardStackPresentable, completion: @escaping (CardView) -> Void) {
        laidCards = []
        viewModel.cardViewModels.forEach {
            let cardFrame = CGRect(origin: frame.origin, size: config.cardSize)
            let cardView = CardView(viewModel: $0, frame: cardFrame)
            laidCards.append(cardView)
            completion(cardView)
        }
    }

    func nextCardPosition() -> CGPoint? {
        return self.frame.origin
    }

    func lay(card: CardView) {
        laidCards.append(card)
    }

    func removeLastCard() {
        _ = laidCards.isEmpty ? nil : laidCards.removeLast()
    }

    func removeAllSubviews() {
        laidCards.forEach { $0.removeFromSuperview() }
        laidCards = []
    }

    private func addRefreshButton() {
        let refreshImageView = UIImageView(image: UIImage(imageLiteralResourceName: config.refreshFile))
        addSubview(refreshImageView)

        refreshImageView.translatesAutoresizingMaskIntoConstraints = false
        refreshImageView.widthAnchor.constraint(equalToConstant: frame.width/2).isActive = true
        refreshImageView.heightAnchor.constraint(equalToConstant: frame.height/2).isActive = true
        refreshImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        refreshImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(refreshSpare(sender:)))
        tapRecognizer.numberOfTapsRequired = 1
        addGestureRecognizer(tapRecognizer)
    }

    @objc private func refreshSpare(sender: UITapGestureRecognizer) {
        delegate?.onRefreshButtonTapped()
    }
}
