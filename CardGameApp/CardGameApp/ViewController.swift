//
//  ViewController.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 21..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties...
    var cardDeck = CardDeck()
    lazy var emptyViews: [UIView] = { [unowned self] in
        var views = [UIView]()
        for _ in 0...3 {
            let emptyView = UIView()
            emptyView.layer.borderWidth = 1
            emptyView.layer.borderColor = UIColor.white.cgColor
            views.append(emptyView)
        }
        return views
    }()

    lazy var backCardImageView: UIImageView = { [unowned self] in
        let image = makeRandomCardImages(1).first
        return UIImageView(image: image!)
    }()

    lazy var cardImageViews: [UIImageView] = { [unowned self] in
        var imageViews = [UIImageView]()
        let images = makeRandomCardImages(7)
        images.forEach {imageViews.append(UIImageView(image: $0))}
        return imageViews
    }()

    // MARK: Override...

    override func viewDidLoad() {
        super.viewDidLoad()
        makeBackGroundImage()
        setUIViewLayout()
    }

    // MARK: Methods...

    private func makeBackGroundImage() {
        guard let patternImage = UIImage(named: "bg_pattern") else {
            return
        }
        view.backgroundColor = UIColor.init(patternImage: patternImage)
    }

    func pickCards(number: Int) -> [Card]? {
        cardDeck.shuffle()
        let cards = cardDeck.pickCards(number: number)
        return cards
    }

    func makeRandomCardImages(_ number: Int) -> [UIImage] {
        guard let cards = pickCards(number: number) else {
            return []
        }
        if number == 1 { return [(cards.first?.makeBackImage())!] }
        var images = [UIImage]()
        cards.forEach { images.append($0.makeImage()!) }
        return images
    }

    func setUIViewLayout() {
        emptyViews.forEach { $0.setLatio() }
        backCardImageView.setLatio()
        cardImageViews.forEach { $0.setLatio() }

        let frontStackVeiw = UIStackView()
        frontStackVeiw.axis = .horizontal
        emptyViews.forEach { frontStackVeiw.addArrangedSubview($0) }
        frontStackVeiw.distribution = .fillEqually
        frontStackVeiw.spacing = 2
        view.addSubview(frontStackVeiw)
        frontStackVeiw.setAutolayout()
        frontStackVeiw.top(equal: view.safeAreaLayoutGuide.topAnchor)
        frontStackVeiw.leading(equal: view.leadingAnchor)

        view.addSubview(backCardImageView)
        backCardImageView.setAutolayout()
        backCardImageView.top(equal: view.safeAreaLayoutGuide.topAnchor)
        backCardImageView.trailing(equal: view.trailingAnchor)

        let backStackVeiw = UIStackView()
        backStackVeiw.axis = .horizontal
        cardImageViews.forEach { backStackVeiw.addArrangedSubview($0) }
        backStackVeiw.distribution = .fillEqually
        backStackVeiw.spacing = 2
        view.addSubview(backStackVeiw)
        backStackVeiw.setAutolayout()
        backStackVeiw.top(equal: frontStackVeiw.bottomAnchor, constant: 2)
        backStackVeiw.leading(equal: view.leadingAnchor)
        backStackVeiw.trailing(equal: view.trailingAnchor)

        frontStackVeiw.trailing(equal: cardImageViews[3].trailingAnchor)
        backCardImageView.leading(equal: cardImageViews[6].leadingAnchor)
    }

}

protocol CardViewLayoutProtocol {
    func setLatio()
}

extension UIView: CardViewLayoutProtocol {
    func setLatio() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.27).isActive = true
    }
}

extension UIView {
    func setAutolayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    func top(equal: NSLayoutYAxisAnchor, constant: CGFloat = 0) {
        self.topAnchor.constraint(equalTo: equal, constant: constant).isActive = true
    }

    func bottom(equal: NSLayoutYAxisAnchor, constant: CGFloat = 0) {
        self.bottomAnchor.constraint(equalTo: equal, constant: constant).isActive = true
    }

    func leading(equal: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        self.leadingAnchor.constraint(equalTo: equal, constant: constant).isActive = true
    }

    func trailing(equal: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        self.trailingAnchor.constraint(equalTo: equal, constant: constant).isActive = true
    }
}
