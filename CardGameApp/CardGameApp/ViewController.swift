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
            imageViews[i].translatesAutoresizingMaskIntoConstraints = false
            imageViews[i].heightAnchor.constraint(equalTo: imageViews[i].widthAnchor, multiplier: 1.27).isActive = true
        }
        return imageViews
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        let stackView = UIStackView()
        stackView.axis = .horizontal
        for i in 0...6 {
            stackView.addArrangedSubview(cardImageViews[i])
        }
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

}

