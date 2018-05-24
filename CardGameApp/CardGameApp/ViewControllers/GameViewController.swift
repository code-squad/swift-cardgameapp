//
//  GameViewController.swift
//  CardGameApp
//
//  Created by yuaming on 02/04/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
  @IBOutlet weak var wastePileView: WastePileView!
  @IBOutlet weak var extraPileView: ExtraPileView!

  private var gameViewModel: GameViewModel!
  private var extraPileViewModel: ExtraPileViewModel!
  private var wastePileViewModel: WasteViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    startGame()
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return UIStatusBarStyle.lightContent
  }
  
  override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
    if motion == .motionShake {
      startGame()
    }
  }
  
  private func startGame() {
    self.gameViewModel = GameViewModel()
    self.gameViewModel.initialize()
  
    initialize()
    registerGestures()
    registerObservers()
  }
}

// MARK:- Initializer
private extension GameViewController {
  func initialize() {
    setBackground()
    setCardSize()
    bindViewModels()
    
    setUpWasteView()
    setUpExtraView()
  }
  
  func setBackground() {
    self.view.backgroundColor = UIColor(patternImage: Image.gameBack)
  }
  
  func setCardSize() {
    ViewSettings.cardWidth = view.frame.size.width / ViewSettings.cardCount.cgFloat - ViewSettings.spacing.cgFloat
    ViewSettings.cardHeight = ViewSettings.cardWidth * 1.27
  }
  
  func setUpExtraView() {
    extraPileView.removeAllViews()
    extraPileViewModel.takeCardModels() { cardViewModel in
      self.extraPileView.addCardView(with: cardViewModel)
    }
  }
  
  func setUpWasteView() {
    wastePileView.removeAllViews()
    wastePileView.addEmptyView()
  }
  
  func registerGestures() {
    let tabGesture = UITapGestureRecognizer(target: self,
                                            action: #selector(extraPileViewDidTap(_:)))
    extraPileView.addTapGesture(tabGesture)
  }
  
  func registerObservers() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(cardDidChoiceInExtraPile(_:)),
                                           name: .cardDidChoiceInExtraPile,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(allCardsDidRemove(_:)),
                                           name: .allCardsDidRemove,
                                           object: nil)
  }
}

// MARK:- Binding gestures
private extension GameViewController {
  @objc func extraPileViewDidTap(_ recognizer: UITapGestureRecognizer) {
    guard let view = recognizer.view as? ExtraPileView,
      let imageView = view.subviews.first as? UIImageView else {
        return
    }
    
    if imageView.image == Image.cardBack {
      executeWhenCardBackImage()
    } else {
      executeWhenRefreshImage()
    }
  }
  
  @objc func cardDidChoiceInExtraPile(_ notification: Notification) {
    guard let userInfo = notification.userInfo,
      let card = userInfo["card"] as? Card,
        let quantity = userInfo["remainingQuantity"] as? Int else { return }
  
    wastePileView.addCardView(with: CardViewModel(card: card, isTurnedOver: true).generate())
    wastePileViewModel.push(card)
    extraPileView.removeView()
    
    if quantity == 0 {
      extraPileView.addRefreshView()
    }
  }
  
  @objc func allCardsDidRemove(_ notification: Notification) {
    guard let userInfo = notification.userInfo,
      let pile = userInfo["pile"] as? CardStack else { return }
    
    self.extraPileViewModel = ExtraPileViewModel(pile)
    setUpWasteView()
    setUpExtraView()
  }
  
  func executeWhenCardBackImage() {
    extraPileViewModel.choice()
  }
  
  func executeWhenRefreshImage() {
    wastePileViewModel.removeAllCards()
  }
}

// MARK:- Binding View Models
private extension GameViewController {
  func bindViewModels() {
    self.extraPileViewModel = ExtraPileViewModel(gameViewModel.extraPile)
    self.wastePileViewModel = WasteViewModel(gameViewModel.wastePile)
    if let vc = childViewControllers.first as? FoundationPilesViewController {
      vc.foundationPilesViewModel = FoundationPilesViewModel(gameViewModel.foundationPiles)
    }

    if let vc = childViewControllers.last as? TableauPilesViewController {
      vc.tableauPilesViewModel = TableauPilesViewModel(gameViewModel.tableauPiles)
    }
  }
}
