//
//  ParallaxCollectionViewLayout.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 3/7/21.
//

import UIKit

class ParallaxCollectionViewLayout: UICollectionViewLayout {
    
    var parallaxOffset: CGPoint?
    var itemSize: CGSize = .zero
    var minLineSpacing: CGFloat = 20.0
    var baseLayoutAttrs = [ParallaxCollectionViewLayoutAttributes]()
    var contentInset: UIEdgeInsets = .zero
    
    override class var layoutAttributesClass: AnyClass {
        return ParallaxCollectionViewLayoutAttributes.self
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        
        baseLayoutAttrs = [ParallaxCollectionViewLayoutAttributes]()
        let noOfItems = collectionView?.numberOfItems(inSection: 0) ?? 0
        
        for item in 0...noOfItems {
            //first item is centered.
            let indexPath = IndexPath(item: item, section: 0)
            let yPos = (collectionView!.frame.height - itemSize.height)/2.0
            let position = CGPoint( x: contentInset.left + ((itemSize.width+minLineSpacing) * CGFloat(item)), y: yPos)
            let frame = CGRect(origin: position, size: itemSize)
            let attrs = ParallaxCollectionViewLayoutAttributes(forCellWith: indexPath)
            attrs.frame = frame
            baseLayoutAttrs.append(attrs)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttrs = baseLayoutAttrs.filter {$0.frame.intersects(rect)}
        
        guard let collectionView = collectionView else { return layoutAttrs}
        
        for attr in layoutAttrs {
            let offset = (attr.frame.minX + collectionView.contentInset.left) - collectionView.contentOffset.x
            let parallaxVal = offset / collectionView.frame.width
            attr.parallaxVal = parallaxVal
        }
        
        return layoutAttrs
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return baseLayoutAttrs[indexPath.row]
    }
    
    override var collectionViewContentSize: CGSize {
        get {
            let totalWidth = CGFloat(baseLayoutAttrs.count-1) * (itemSize.width + self.minLineSpacing) + (contentInset.left + contentInset.right)
            return CGSize(width: totalWidth, height: itemSize.height
            )
        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
