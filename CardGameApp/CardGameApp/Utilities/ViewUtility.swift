//
//  ViewUtility.swift
//  CardGameApp
//
//  Created by yuaming on 18/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation
import UIKit

struct ViewUility {
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
}
