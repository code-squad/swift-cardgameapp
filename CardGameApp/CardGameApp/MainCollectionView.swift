//
//  MainCollectionView.swift
//  CardGameApp
//
//  Created by Jung seoung Yeo on 2018. 6. 13..
//  Copyright © 2018년 Clover. All rights reserved.
//

import UIKit

class MainCollectionView: UICollectionViewController {
    
    private let cardRatio = CGFloat(1.27)
    private let width = (UIScreen.main.bounds.width / 7)
    private let margin = (UIScreen.main.bounds.width / 7) / 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor(patternImage: .init(imageLiteralResourceName: "bg_pattern"))
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CardCell")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: width - margin, height: (width - margin) * cardRatio)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }
    
}

extension MainCollectionView: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath)
        cell.backgroundView = UIImageView(image: UIImage(named: "card-back"))
        return cell
    }
    
}
