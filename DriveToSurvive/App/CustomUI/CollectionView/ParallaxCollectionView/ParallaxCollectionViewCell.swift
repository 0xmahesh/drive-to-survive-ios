//
//  ParallaxCollectionViewCell.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 3/7/21.
//

import UIKit

class ParallaxCollectionViewCell: UICollectionViewCell, ParallaxCardViewPresentable, NSCopying {
    
    static let reuseIdentifier = "ParallaxCollectionViewCell"
    
    var parallaxCardView = ParallaxCardView(frame: .zero)
    
    var isFullScreen: Bool = false {
        didSet {
            parallaxCardView.isFullScreen = isFullScreen
        }
    }
    
    
    var parallaxVal: CGFloat = 0 {
        didSet {
            parallaxCardView.parallaxVal = parallaxVal
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        parallaxCardView.adaptToSystemInterfaceStyle()
        contentView.addSubview(parallaxCardView)
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        guard let layoutAttrs = layoutAttributes as? ParallaxCollectionViewLayoutAttributes else { return }
        parallaxVal = layoutAttrs.parallaxVal
    }
    
    func update(with image: UIImage, title: String, subtitle: String) {
        parallaxCardView.update(with: image, title: title, subtitle: subtitle)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        parallaxCardView.frame = CGRect(origin: .zero, size: frame.size)
        parallaxCardView.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        parallaxCardView.adaptToSystemInterfaceStyle()
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let parallaxCardView = self.parallaxCardView.copy() as! ParallaxCardView
        let instance = ParallaxCollectionViewCell(frame: self.frame)
        instance.parallaxCardView.removeFromSuperview()
        instance.parallaxCardView = parallaxCardView
        instance.contentView.addSubview(parallaxCardView)
        return instance
    }
    
}
