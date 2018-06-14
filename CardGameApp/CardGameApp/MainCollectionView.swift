//
//  MainCollectionView.swift
//  CardGameApp
//
//  Created by Jung seoung Yeo on 2018. 6. 13..
//  Copyright © 2018년 Clover. All rights reserved.
//

import UIKit

class MainCollectionView: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor(patternImage: .init(imageLiteralResourceName: "bg_pattern"))
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CardCell")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(CARDGAMEAPP.LAYOUT.horizonCardCount.rawValue)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
                    width: CARDGAMEAPP.LAYOUT.width.rawValue - CARDGAMEAPP.LAYOUT.margin.rawValue,
                    height: (CARDGAMEAPP.LAYOUT.width.rawValue - CARDGAMEAPP.LAYOUT.margin.rawValue) * CARDGAMEAPP.LAYOUT.cardRatio.rawValue)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CARDGAMEAPP.LAYOUT.margin.rawValue
    }
    
}

extension MainCollectionView: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath)
        cell.backgroundView = UIImageView(image: UIImage(named: "card-back"))
        return cell
    }
    
}
