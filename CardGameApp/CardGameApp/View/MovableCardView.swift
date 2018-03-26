//
//  MovableCardView.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 14..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class MovableCardView: UIView, CanFindGameView {
    weak var delegate: UpdateModelDelegate?
    private var cardView: CardView
    private var cardViewsBelow: [CardView]?
    private var startPosition: CGPoint = .zero
    private var fromLocation: Location
    private(set) var endLocation: Location

    init(cardView: CardView, cardViewsBelow: [CardView]?, endLocation: Location) {
        self.cardView = cardView
        self.cardViewsBelow = cardViewsBelow
        self.fromLocation = cardView.viewModel!.location.value
        self.endLocation = endLocation
        self.startPosition = cardView.frame.origin

        let wholeHeight = (cardViewsBelow == nil) ? cardView.frame.height : cardView.frame.height+cardView.frame.height*0.3*(CGFloat(cardViewsBelow!.count)-1)
        let wholeSize = CGSize(width: cardView.frame.width, height: wholeHeight)
        super.init(frame: CGRect(origin: startPosition, size: wholeSize))

        addSubview(cardView)
        cardViewsBelow?.forEach { addSubview($0) }
    }

    required init?(coder aDecoder: NSCoder) {
        self.cardView = CardView(frame: .zero)
        self.fromLocation = .spare
        self.endLocation = .spare
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        self.cardView.frame.origin = self.frame.origin
        self.cardViewsBelow?.enumerated().forEach {
            $0.element.frame.origin =
                CGPoint(x: self.cardView.frame.origin.x,
                        y: self.cardView.frame.origin.y+CGFloat($0.offset+1)*cardView.frame.height*0.3)
        }

        self.cardView.removeFromSuperview()
        self.superview?.addSubview(self.cardView)
        self.cardViewsBelow?.forEach {
            $0.removeFromSuperview()
            self.superview?.addSubview($0)
        }
        self.removeFromSuperview()

        super.layoutSubviews()
    }

    func animateToMove(to endPosition: CGPoint?) {
        guard let endPosition = endPosition else { return }

        let translateTransform = self.transform.translatedBy(x: endPosition.x-startPosition.x,
                                                             y: endPosition.y-startPosition.y)

        UIView.transition(with: self, duration: 0.3, options: .curveEaseOut, animations: {
            self.bringToFront()
            self.transform = translateTransform
            self.layoutIfNeeded()
        }, completion: { _ in
            self.updateSuperview()
            self.updateModel()
        })

    }

    // MARK: - PRIVATE

    func bringToFront() {
        superview?.bringSubview(toFront: self)
    }

    private func updateSuperview() {
        // 카드뷰가 속한 상위뷰 업데이트 (실제로는 gameView의 subview 임)
        self.handleCertainView(from: self.cardView, execute: { gameView in
            var endView: CanLayCards
            switch self.endLocation {
            case .spare: endView = gameView.spareView
            case .waste: endView = gameView.wasteView
            case .foundation(let index): endView = gameView.foundationViewContainer.at(index)
            case .tableau(let index): endView = gameView.tableauViewContainer.at(index)
            }
            self.cardView.move(toView: endView)
            self.cardViewsBelow?.forEach {
                $0.move(toView: endView)
            }
        })
    }

    private func updateModel() {
        // 모델 업데이트
        let prevEndLocation = self.endLocation
        switch self.endLocation {
        case .spare: self.delegate?.refreshWaste()
        default:
            self.delegate?.move(cardViewModel: self.cardView.viewModel!,
                                     from: self.fromLocation, to: self.endLocation)
        }
        // 모델 업데이트 후, 카드 뷰모델의 Location 데이터 업데이트
        self.delegate?.update(cardViewModel: self.cardView.viewModel!, to: prevEndLocation)
        self.cardViewsBelow?.forEach { [unowned self] in
            self.delegate?.update(cardViewModel: $0.viewModel!, to: prevEndLocation)
        }
    }
}
