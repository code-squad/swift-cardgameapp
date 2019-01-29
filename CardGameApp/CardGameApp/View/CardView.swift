//
//  CardView.swift
//  CardGameApp
//
//  Created by 윤지영 on 23/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

class CardView: UIImageView {

    var viewModel: CardViewModelDelegate! {
        didSet {
            viewModel.imageDidChange = { [unowned self] viewModel in
                self.setImage(named: viewModel.imageName)
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    convenience init(origin: CGPoint = CGPoint(), size: CGSize) {
        let frame = CGRect(origin: origin, size: size)
        self.init(frame: frame)
    }

    private func setUp() {
        setImage()
        roundCorners()
    }

    func setImage(named name: String? = nil) {
        let name: String = name ?? "card-back.png"
        guard let image = UIImage(named: name) else { return }
        self.image = image
    }

    private func roundCorners() {
        layer.cornerRadius = 4
        layer.masksToBounds = true
    }

    func flip() {
        viewModel.flip()
    }

}
