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
  private var extraPileViewModel: ExtraPileViewModel! {
    didSet {
      self.extraPileViewModel.delegate = self
    }
  }
  
  private var wastePileViewModel: WasteViewModel! {
    didSet {
      self.wastePileViewModel.delegate = self
    }
  }
  
  private var tableauPilesViewController: TableauPilesViewController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.gameViewModel = GameViewModel()
    self.gameViewModel.initialize()
    
    initialize()
    registerGestures()
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return UIStatusBarStyle.lightContent
  }
}

// MARK:- Initializer
private extension GameViewController {
  func initialize() {
    setBackground()
    setCardSize()
    bindViewModels()
    
    configueExtraPileView()
    configueWastePileView()
  }
  
  func setBackground() {
    self.view.backgroundColor = UIColor(patternImage: Image.gameBack)
  }
  
  func setCardSize() {
    ViewSettings.cardWidth = view.frame.size.width / CGFloat(ViewSettings.cardCount) - ViewSettings.spacing
    ViewSettings.cardHeight = ViewSettings.cardWidth * 1.27
  }
  
  func registerGestures() {
    let tabGesture = UITapGestureRecognizer(target: self,
                                            action: #selector(extraPileViewDidTap(_:)))
    extraPileView.addTapGesture(tabGesture)
  }
  
  func configueExtraPileView() {
    extraPileViewModel.addCardViewModels()
  }
  
  func configueWastePileView() {
    wastePileViewModel.addCardViewModels()
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
      executeWhenCardIsBack()
    } else {
      executeWhenRefreshedImage()
    }
  }
  
  func executeWhenCardIsBack() {
    if extraPileViewModel.isAvailable {
      guard let card = extraPileViewModel.choiceOneCard() else { return }
      wastePileViewModel.push(card)
      wastePileViewModel.addCardViewModel(card, status: .front)
    } else {
      extraPileViewModel.setRefresh()
    }
  }
  
  func executeWhenRefreshedImage() {
    guard let cardStack = wastePileViewModel.removeAllCards() else { return }
    wastePileView.removeAllViews()
    wastePileViewModel.addCardViewModels()
    extraPileView.removeAllViews()
    extraPileViewModel.store(with: cardStack)
    extraPileViewModel.addCardViewModels()
  }
}

// MARK:- GameViewControllerDelegate
extension GameViewController: GameViewControllerDelegate {
  func setCardViewModelInExtraPile(_ cardViewModel: CardViewModel) {
    extraPileView.addView(cardViewModel)
  }
  
  func setCardViewModelInWastePile(_ cardViewModel: CardViewModel) {
    wastePileView.addView(cardViewModel)
  }
  
  func setEmptyViewInExtraPile() {
    extraPileView.addView(nil)
  }
  
  func setEmptyViewInWastePile() {
    wastePileView.addView(nil)
  }
  
  func setRefreshViewInExtraPile() {
    extraPileView.removeAllViews()
    extraPileView.addRefreshView()
  }
}

// MARK:- Binding view models
private extension GameViewController {
  func bindViewModels() {
    self.extraPileViewModel = ExtraPileViewModel(gameViewModel.extraPile)
    self.wastePileViewModel = WasteViewModel(gameViewModel.wastePile)
    if let vc = childViewControllers.first as? FoundationPilesViewController {
      vc.foundationViewModel = FoundationPilesViewModel(gameViewModel.foundationPiles)
    }
    
//    if let vc = childViewControllers.last as? TableauPilesViewController { }
  }
}
