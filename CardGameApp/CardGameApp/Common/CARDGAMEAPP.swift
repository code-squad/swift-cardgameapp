//
//  CARDGAMEAPP.swift
//  CardGameApp
//
//  Created by Jung seoung Yeo on 2018. 6. 14..
//  Copyright © 2018년 Clover. All rights reserved.
//
import UIKit

enum CARDGAMEAPP {
    enum LAYOUT {
        case horizonCardCount
        case width
        case cardRatio
        case margin
        case top
        
        var rawValue: CGFloat {
            switch self {
            case .horizonCardCount:
                return 7
            case .cardRatio:
                return 1.27
            case .width:
                return (UIScreen.main.bounds.width / CARDGAMEAPP.LAYOUT.horizonCardCount.rawValue) - ((UIScreen.main.bounds.width / CARDGAMEAPP.LAYOUT.horizonCardCount.rawValue)) / 20
            case .margin:
                return CARDGAMEAPP.LAYOUT.width.rawValue / 30
            case .top:
                return 20
            }
        }
    }
    
    enum Attributes {
        case foundationField
        case deckField
        
        var instance: UIImageView {
            switch self {
                case .foundationField:
                    let card: UIImageView = UIImageView()
                    card.layer.borderColor = UIColor.white.cgColor
                    card.layer.borderWidth = 1
                    card.contentMode = .scaleAspectFit
                    card.clipsToBounds = true
                    card.layer.cornerRadius = 5
                return card
            
                case .deckField:
                    let card = UIImageView()
                    card.image = UIImage(named: "card-back")
                    card.contentMode = .scaleAspectFit
                    card.clipsToBounds = true
                    card.layer.cornerRadius = 5
                    return card
                }
        }
    }
}
