//
//  CardView.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 3. 23..
//  Copyright © 2018년 Napster. All rights reserved.
//

import UIKit

class CardView: UIImageView {
    
    override init(image: UIImage?) {
        super.init(image: image)
        makeBasicView()
        self.frame.origin = CGPoint.zero
    }
    
    init() {
        super.init(frame: CGRect(origin: CGPoint.zero, size: CardView.cardSize()))
        self.isUserInteractionEnabled = true
        makeBasicView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func makeBasicView() {
        self.bounds = CGRect(origin: CGPoint.zero, size: CardView.cardSize())
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    func arrangeCardView(xPoint: CGFloat, yPoint: CGFloat) {
        let xPoint = ((CardView.cardSize().width + CardView.marginBetweenCard()) * CGFloat(xPoint)) + CardView.marginBetweenCard()
        self.frame.origin = CGPoint(x: xPoint, y: yPoint)
    }
    
    func arrangeCardViewInStack(yPoint: CGFloat) {
        self.frame.origin = CGPoint(x: CGFloat(ScreenPoint.startXPoint), y: CGFloat(yPoint) * 20)
    }
}

extension CardView {
    class func cardSize() -> CGSize {
        let screenWidth = UIScreen.main.fixedCoordinateSpace.bounds.width
        let marginRatio: CGFloat = 70
        let cardColumns: CGFloat = 7
        let cardWidth = (screenWidth / cardColumns) - (screenWidth / marginRatio)
        let cardHeight = (screenWidth / cardColumns) * 1.27
        return CGSize(width: cardWidth, height: cardHeight)
    }
    
    class func marginBetweenCard() -> CGFloat {
        let cardFrame = self.cardSize()
        let screenWidth = UIScreen.main.fixedCoordinateSpace.bounds.width
        let margin = (screenWidth - (cardFrame.width * 7)) / 8
        return margin
    }
}
