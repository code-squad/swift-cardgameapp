//
//  UIImageView+CardView.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 1. 29..
//  Copyright © 2018년 Napster. All rights reserved.
//

import UIKit

extension UIView {
    func makeBasicView() {
        self.bounds = CGRect(origin: CGPoint.zero, size: self.cardSize())
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    func makeCardView(index: CGFloat) {
        self.makeCardView(index: index, yPoint: UIApplication.shared.statusBarFrame.height)
    }
    
    func makeCardView(index: CGFloat, yPoint: CGFloat) {
        let xPoint = ((self.cardSize().width + self.marginBetweenCard()) * CGFloat(index)) + self.marginBetweenCard()
        self.makeBasicView()
        self.frame.origin = CGPoint(x: xPoint, y: yPoint)
    }
    
    func makeCardView(yPoint: CGFloat) {
        self.makeBasicView()
        self.frame.origin = CGPoint(x: 0, y: yPoint)
    }
    
    func cardSize() -> CGSize {
        let screenWidth = UIScreen.main.fixedCoordinateSpace.bounds.width
        let marginRatio: CGFloat = 70
        let cardColumns: CGFloat = 7
        let cardWidth = (screenWidth / cardColumns) - (screenWidth / marginRatio)
        let cardHeight = (screenWidth / cardColumns) * 1.27
        return CGSize(width: cardWidth, height: cardHeight)
    }
    
    func marginBetweenCard() -> CGFloat {
        let cardFrame = self.cardSize()
        let screenWidth = UIScreen.main.fixedCoordinateSpace.bounds.width
        let margin = (screenWidth - (cardFrame.width * 7)) / 8
        return margin
    }
    
    func refreshButton() {
        guard let image = UIImage(named: "cardgameapp-refresh-app") else { return }
        let screenWidth = UIScreen.main.fixedCoordinateSpace.bounds.width
        let yPoint = UIApplication.shared.statusBarFrame.height
        let ratio = screenWidth / 1000
        let imageWidth = ratio * image.size.width
        self.frame = CGRect(x: screenWidth - (imageWidth + (imageWidth / CGFloat(3))),
                            y: yPoint + 20,
                            width: ratio * image.size.width,
                            height: ratio * image.size.height)
        self.contentMode = UIViewContentMode.scaleAspectFit
    }
}
