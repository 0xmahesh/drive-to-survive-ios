//
//  NewsDetailCollectionViewFlowLayout.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 3/27/21.
//

import UIKit

class NewsDetailCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        layoutAttributes?.forEach { (attributes) in
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader {
                
                
                guard let collectionView = collectionView else { return }
                let width = collectionView.frame.width - 40
                let height = attributes.frame.height
                let contentOffsetY = collectionView.contentOffset.y
                
                if contentOffsetY > 0 {
                    return
                }
                
                //header
                attributes.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height - contentOffsetY)
            }
            
        }
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
