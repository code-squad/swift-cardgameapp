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
        return makeRandomCardImageViews()
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

    private func makeRandomCardImageViews() -> [UIImageView] {
        var imageViews = [UIImageView]()
        let images = makeRandomCardImages(7)
        images.forEach {imageViews.append(UIImageView(image: $0))}
        return imageViews
    }

    private func setUIViewLayout() {
        setEmptyViewLayout()
        setBackCardViewLayout()
        setCardViewLayout()
    }

    private func setEmptyViewLayout() {
        for i in 0..<emptyViews.count {
            self.view.addSubview(emptyViews[i])
            emptyViews[i].setLatio()
            emptyViews[i].top(equal: self.view)
            if i==0 {
                emptyViews[i].leading(equal: self.view.leadingAnchor, constant: 3)
            } else {
                emptyViews[i].leading(equal: emptyViews[i-1].trailingAnchor, constant: 3)
            }
            emptyViews[i].width(constant: 55)
        }
    }

    private func setCardViewLayout() {
        for i in 0..<cardImageViews.count {
            self.view.addSubview(cardImageViews[i])
            cardImageViews[i].setLatio()
            cardImageViews[i].top(equal: self.view, constant: 100)
            if i==0 {
                cardImageViews[i].leading(equal: self.view.leadingAnchor, constant: 3)
            } else {
                cardImageViews[i].leading(equal: cardImageViews[i-1].trailingAnchor, constant: 3)
            }
            cardImageViews[i].width(constant: 55)
        }
    }

    private func setBackCardViewLayout() {
        self.view.addSubview(backCardImageView)
        backCardImageView.setLatio()
        backCardImageView.top(equal: self.view)
        backCardImageView.trailing(equal: self.view.trailingAnchor, constant: -3)
        backCardImageView.width(constant: 55)
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

    func top(equal: UIView, constant: CGFloat = 0) {
        self.topAnchor.constraint(equalTo: equal.safeAreaLayoutGuide.topAnchor, constant: constant).isActive = true
    }

    func leading(equal: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        self.leadingAnchor.constraint(equalTo: equal, constant: constant).isActive = true
    }

    func trailing(equal: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        self.trailingAnchor.constraint(equalTo: equal, constant: constant).isActive = true
    }

    func width(constant: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
}
