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
  
  static func addEmptyView(view: UIView) {
    let emptyView = UIImageView()
    emptyView.generateEmptyView()
    view.addSubview(emptyView)
  }
  
  static func addCardView(view: UIView, with viewModel: CardViewModel) {
    let cardView = CardView(viewModel: viewModel)
    view.addSubview(cardView)
  }
  
  static func fitFrame(view: UIView, widthPosition: Int = 0, heightPosition: Int = 0) {
    view.frame = view.setFrame(widthPosition: widthPosition, heightPosition: heightPosition)
  }
}
