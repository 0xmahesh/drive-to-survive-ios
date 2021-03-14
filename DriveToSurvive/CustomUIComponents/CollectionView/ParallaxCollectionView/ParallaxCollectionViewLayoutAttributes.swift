//
//  ParallaxCollectionViewLayoutAttributes.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 3/7/21.
//

import UIKit

class ParallaxCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    var parallaxVal: CGFloat = 0
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let attr = super.copy(with: zone) as! ParallaxCollectionViewLayoutAttributes
        attr.parallaxVal = self.parallaxVal
        return attr
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let obj = object as? ParallaxCollectionViewLayoutAttributes else { return false }
        guard obj.parallaxVal == parallaxVal else { return false }
        return super.isEqual(obj)
    }
}
