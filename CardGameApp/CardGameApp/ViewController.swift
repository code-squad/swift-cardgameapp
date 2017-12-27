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

    private func pickCards(number: Int) -> [Card]? {
        cardDeck.shuffle()
        let cards = cardDeck.pickCards(number: number)
        return cards
    }

    private func makeRandomCardImages(_ number: Int) -> [UIImage] {
        guard let cards = pickCards(number: number) else {
            return []
        }
        if number == 1 { return [(cards[0].makeBackImage())!] }
        var images = [UIImage]()
        cards.forEach { images.append($0.makeImage()!) }
        return images
    }

    private func setUIViewLayout() {
        emptyViews.forEach { $0.setLatio() }
        backCardImageView.setLatio()
        cardImageViews.forEach { $0.setLatio() }

        var frontStackVeiw = UIStackView()
        makeGridViews(stackview: &frontStackVeiw, contentsview: &emptyViews)
        view.addSubview(frontStackVeiw)
        frontStackVeiw.setAutolayout()
        frontStackVeiw.top(equal: view.safeAreaLayoutGuide.topAnchor)
        frontStackVeiw.leading(equal: view.leadingAnchor)

        view.addSubview(backCardImageView)
        backCardImageView.setAutolayout()
        backCardImageView.top(equal: view.safeAreaLayoutGuide.topAnchor)
        backCardImageView.trailing(equal: view.trailingAnchor)

        var backStackVeiw = UIStackView()
        makeGridViews(stackview: &backStackVeiw, contentsview: &cardImageViews)
        view.addSubview(backStackVeiw)
        backStackVeiw.setAutolayout()
        backStackVeiw.top(equal: frontStackVeiw.bottomAnchor, constant: 10)
        backStackVeiw.leading(equal: view.leadingAnchor)
        backStackVeiw.trailing(equal: view.trailingAnchor)

        frontStackVeiw.trailing(equal: cardImageViews[3].trailingAnchor)
        backCardImageView.leading(equal: cardImageViews[6].leadingAnchor)
    }

    private func makeGridViews<T>(stackview: inout UIStackView, contentsview: inout [T]) {
        stackview.axis = .horizontal
        contentsview.forEach { stackview.addArrangedSubview(($0 as? UIView)!) }
        stackview.distribution = .fillEqually
        stackview.spacing = 2
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
