//
//  BoardView.swict
//  CardGameApp
//
//  Created by yuaming on 03/04/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class BoardView: UIView {
  override func layoutSubviews() {
    super.layoutSubviews()
    loadDefaultOptions()
  }
}

extension BoardView {
  static var statusHeight: CGFloat {
    let statusBarSize = UIApplication.shared.statusBarFrame.size
    return statusBarSize.height
  }
}

private extension BoardView {
  func loadDefaultOptions() {
    self.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "GameBoard"))
  }
}
