//
//  UIImageView+CardView.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 1. 29..
//  Copyright © 2018년 Napster. All rights reserved.
//

import UIKit

extension UIView {
//    func makeViewPoint(columnIndex: CGFloat, rowIndex: CGFloat) -> CGPoint {
//        let xPoint = (CardView.cardSize().width + UIView.marginBetweenCard()) * columnIndex + UIView.marginBetweenCard()
//        let yPoint = UIApplication.shared.statusBarFrame.height + (CardView.cardSize().height * rowIndex)
//        return CGPoint(x: xPoint, y: yPoint)
//    }
    
//    func makeZeroOrigin() {
//        self.frame.origin = CGPoint.zero
//    }

//    func makeCardView() {
//        self.makeCardView(index: 0, yPoint: 0)
//    }
    
//    func makeCardView(index: CGFloat) {
//        self.makeCardView(index: index, yPoint: UIApplication.shared.statusBarFrame.height)
//    }
    
//    func makeCardView(yPoint: CGFloat) {
//        self.makeBasicView()
//        self.frame.origin = CGPoint(x: 0, y: yPoint)
//    }
    
//    func makeCardView(index: CGFloat, yPoint: CGFloat) {
//        let xPoint = ((CardView.cardSize().width + UIView.marginBetweenCard()) * CGFloat(index)) + UIView.marginBetweenCard()
//        self.makeBasicView()
//        self.frame.origin = CGPoint(x: xPoint, y: yPoint)
//    }
    
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
