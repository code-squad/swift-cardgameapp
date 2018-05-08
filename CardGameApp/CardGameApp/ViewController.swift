//
//  ViewController.swift
//  CardGameApp
//
//  Created by yuaming on 02/04/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  private var cardDeck: CardDeck!
  private var boardView: BoardView!
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return UIStatusBarStyle.lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
}

private extension ViewController {
  func setup() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(updateCardDeck(notification:)),
      name: Notification.Name.cardDeck,
      object: nil
    )
    
    self.cardDeck = CardDeck.share()
    layoutWithInitializer()
  }
  
  @objc func updateCardDeck(notification: Notification) {
    if let cardDeck = notification.object as? CardDeck {
      self.cardDeck = cardDeck
    }
  }
}

private extension ViewController {
  func layoutWithInitializer() {
    let headerPanel = layoutWithHeader()
    let bodyPanel = layoutWithBody()
    
    self.view.addSubview(headerPanel)
    self.view.addSubview(bodyPanel)
    
    headerPanel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
    headerPanel.heightAnchor.constraint(equalToConstant: self.getStackViewHeight).isActive = true
    headerPanel.topAnchor.constraintEqualToSystemSpacingBelow(view.safeAreaLayoutGuide.topAnchor, multiplier: 1).isActive = true
    
    bodyPanel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
    bodyPanel.heightAnchor.constraint(equalToConstant: self.getStackViewHeight).isActive = true
    bodyPanel.topAnchor.constraint(equalTo: headerPanel.bottomAnchor, constant: 20).isActive = true
  }
  
  func layoutWithHeader() -> UIStackView {
    return setStackView([
        generateEmptyView(true),
        generateEmptyView(true),
        generateEmptyView(true),
        generateEmptyView(true),
        generateEmptyView(false),
        generateEmptyView(false),
        generateCardView(false)
    ])
  }
  
  func layoutWithBody() -> UIStackView {
    var cardViews: [CardView] = []
    
    for _ in 0..<GameConfig.cardCount {
      cardViews.append(generateCardView(true))
    }
    
    return setStackView(cardViews)
  }
  
  func setStackView(_ subviews: [UIView]) -> UIStackView {
    let stackView = UIStackView(arrangedSubviews: subviews)
    
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.spacing = 5
    stackView.distribution = .fillEqually
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    return stackView
  }
  
  func generateEmptyView(_ hasBorder: Bool) -> EmptyView {
    return EmptyView(frame: GameConfig.defaultFrame, hasBorder: hasBorder)
  }
  
  func generateCardView(_ isFront: Bool) -> CardView {
    guard isFront else {
      return CardView(frame: GameConfig.defaultFrame)
    }
    
    return CardView(frame: GameConfig.defaultFrame, card: try! cardDeck.remove())
  }
  
  var getStackViewHeight: CGFloat {
    let width = self.view.frame.width / CGFloat(GameConfig.cardCount)
    return width * 1.27
  }
}
