//
//  ViewUtility.swift
//  CardGameApp
//
//  Created by yuaming on 18/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation
import UIKit

struct ViewUtility {
  static func addChildViewController(child: UIViewController, to parent: UIViewController) {
    parent.addChildViewController(child)
    parent.view.addSubview(child.view)
    child.didMove(toParentViewController: parent)
  }
  
  static func removeChildViewController(child: UIViewController) {
    child.willMove(toParentViewController: nil)
    child.view.removeFromSuperview()
    child.removeFromParentViewController()
  }
  
  static func addEmptyView(in view: UIView, widthPosition: Int = 0, heightPosition: Int = 0) {
    let emptyView = UIImageView()
    emptyView.generateEmptyView(widthPosition: widthPosition, heightPosition: heightPosition)
    view.addSubview(emptyView)
  }
  
  static func addCardView(in view: UIView, with viewModel: CardViewModel, widthPosition: Int = 0, heightPosition: Int = 0) {
    let cardView = CardView(viewModel: viewModel)
    cardView.frame = UIView.setFrame(widthPosition: widthPosition, heightPosition: heightPosition)
    view.addSubview(cardView)
  }
}
