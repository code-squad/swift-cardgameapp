//
//  UIView.swift
//  CardGameApp
//
//  Created by yuaming on 18/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

extension UIView {
  class func setFrame(widthPosition: Int = 0, heightPosition: Int = 0) -> CGRect {
    let yPoint = heightPosition == 0 ? 0 : heightPosition.cgFloat * 15
    return CGRect(origin: CGPoint(x: ViewSettings.cardWidth * widthPosition.cgFloat,
                                  y: yPoint),
                  size: CGSize(width: ViewSettings.cardWidth, height: ViewSettings.cardHeight))
  }
  
  class func addEmptyView(in view: UIView, widthPosition: Int = 0, heightPosition: Int = 0) {
    let emptyView = UIImageView()
    emptyView.generateEmptyView(widthPosition: widthPosition, heightPosition: heightPosition)
    view.addSubview(emptyView)
  }
  
  class  func addCardView(in view: UIView, with viewModel: CardViewModel, widthPosition: Int = 0, heightPosition: Int = 0) {
    let cardView = CardView(viewModel: viewModel)
    cardView.frame = UIView.setFrame(widthPosition: widthPosition, heightPosition: heightPosition)
    view.addSubview(cardView)
  }
}
