//
//  BaseViewController.swift
//  CardGameApp
//
//  Created by yuaming on 24/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func addChildViewController(child: UIViewController) {
    self.addChildViewController(child)
    self.view.addSubview(child.view)
    child.didMove(toParentViewController: self)
  }
  
  func removeChildViewController(child: UIViewController) {
    child.willMove(toParentViewController: nil)
    child.view.removeFromSuperview()
    child.removeFromParentViewController()
  }
}
