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
    
    self.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: LiteralResoureNames.board))
  }
}
