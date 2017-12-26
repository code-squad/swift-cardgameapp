//
//  ViewController.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 21..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var cardImageViews: [UIImageView] = { [unowned self] in
        var imageViews = [UIImageView]()
        let image = UIImage(named: "card-back")
        for i in 0...6 {
            imageViews.append(UIImageView(image: image!))
            makeCardViewPosition(view: &imageViews[i])
        }
        return imageViews
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeBackGroundImage()
        allocateCardImageViews()
    }

    private func makeBackGroundImage() {
        guard let patternImage = UIImage(named: "bg_pattern") else {
            return
        }
        view.backgroundColor = UIColor.init(patternImage: patternImage)
    }

    private func allocateCardImageViews() {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        for i in 0...6 {
            stackView.addArrangedSubview(cardImageViews[i])
        }
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        view.addSubview(stackView)
        makeStackViewPosition(view: &stackView)
    }

    private func makeStackViewPosition(view: inout UIStackView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }

    private func makeCardViewPosition(view: inout UIImageView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.27).isActive = true
    }

}
