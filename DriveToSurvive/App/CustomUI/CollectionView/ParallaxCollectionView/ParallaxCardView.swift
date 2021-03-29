//
//  ParallaxCardView.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 3/7/21.
//

import UIKit

protocol ParallaxCardViewDrawable {
    var imageSizeRatio: CGSize { get }
    
    func drawRect(rect: CGRect, imageView: UIView, bottomContainerView: UIView, parallaxVal: CGFloat)
}

protocol ParallaxCardViewPresentable {
    var isFullScreen: Bool { get set }
}

struct ParallaxCardViewTemplate: ParallaxCardViewDrawable {
    var imageSizeRatio: CGSize = CGSize(width: 1.3, height: 0.7)
    
    func drawRect(rect: CGRect, imageView: UIView, bottomContainerView: UIView, parallaxVal: CGFloat) {
        let maxOffset = -rect.width/3 - (rect.width/3)
        let posX = maxOffset * parallaxVal
        
        imageView.frame = CGRect(x: posX, y: 0, width: rect.width * imageSizeRatio.width, height: rect.height * imageSizeRatio.height)
        
        bottomContainerView.frame = CGRect(origin: CGPoint(x: 0, y: imageView.frame.height), size: CGSize(width: rect.width, height: rect.height * (1-imageSizeRatio.height)))
        
        bottomContainerView.alpha = 1
    }
}

struct ParallaxCardViewFullScreenTemplate: ParallaxCardViewDrawable {
    var imageSizeRatio: CGSize = CGSize(width: 1.0, height: 0.5)
    
    func drawRect(rect: CGRect, imageView: UIView, bottomContainerView: UIView, parallaxVal: CGFloat = 0) {
        imageView.frame = CGRect(x: 0, y: 0, width: rect.width * imageSizeRatio.width, height: rect.height * imageSizeRatio.height)
        
        //print("rect: \(rect)")
        let yOffset: CGFloat = (UIScreen.main.bounds.height/2) - (UIDevice.current.hasNotch ? 47.0 : 0) + (UIDevice.current.hasNotch ? 78.0 : 44.0)
        
        bottomContainerView.frame = CGRect(origin: CGPoint(x: 0, y: yOffset), size: CGSize(width: rect.width, height: rect.height * (1-imageSizeRatio.height)))
        
        bottomContainerView.alpha = 0
    }
    
}

class ParallaxCardView: UIView, ParallaxCardViewPresentable, NSCopying {
    
    var contentView = UIView()
    var imageView = UIImageView()
    var bottomContainerView = UIView()
    
    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()
    
    var cornerRadius: CGFloat = 10.0
    var offset: CGFloat = 2.0 * 35.0
    let verticalPadding: CGFloat = 3.0
    let leftPadding: CGFloat = 20.0
    
    var imageHeightRatio: CGFloat = 0.7
    
    var parallaxVal: CGFloat = 0 {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.layoutSubviews()
            }
        }
    }
    
    var isFullScreen: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        layer.shouldRasterize = false
        layer.cornerRadius = cornerRadius
        
        layer.shadowRadius = 10.0
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
        
        contentView.frame = CGRect(origin: .zero, size: frame.size)
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = cornerRadius
        
        imageView.frame = CGRect(x: 0, y: 0, width: bounds.width + offset, height: 0)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        bottomContainerView.layer.masksToBounds = true

        
        titleLabel.font = UIFont(name: "Formula1-Display-Bold", size: 18)
        titleLabel.numberOfLines = 2
        
        subtitleLabel.font = UIFont(name: "Helvetica", size: 14)
        subtitleLabel.numberOfLines = 2
        contentView.addSubview(imageView)
        contentView.addSubview(bottomContainerView)
        bottomContainerView.addSubview(titleLabel)
        bottomContainerView.addSubview(subtitleLabel)
        
        addSubview(contentView)
        
//        titleLabel.frame.origin = CGPoint(x: leftPadding, y: bottomContainerView.frame.height/2 - (titleLabel.frame.height + verticalPadding))
//        titleLabel.frame.width = UIScreen.main.bounds.width - 2*leftPadding
//        subtitleLabel.frame.origin = CGPoint(x: leftPadding, y: bottomContainerView.frame.height/2 + 10.0)
//        subtitleLabel.frame.width = UIScreen.main.bounds.width - 2*leftPadding
        
        adaptToSystemInterfaceStyle()
    }
    
    public func adaptToSystemInterfaceStyle() {
        if traitCollection.userInterfaceStyle == .dark {
            layer.shadowColor = UIColor.white.cgColor
            backgroundColor = .black
            titleLabel.textColor = .white
            subtitleLabel.textColor = UIColor(white: 0.8, alpha: 1)
        } else {
            layer.shadowColor = UIColor.black.cgColor
            backgroundColor = .white
            titleLabel.textColor = .black
            subtitleLabel.textColor = .gray
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(with image: UIImage, title: String, subtitle: String) {
        imageView.image = image
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
        DispatchQueue.main.async {
            self.titleLabel.sizeToFit()
            self.subtitleLabel.sizeToFit()
            
            self.layoutSubviews()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        adaptToSystemInterfaceStyle()
        
        
        layer.cornerRadius = cornerRadius
        contentView.layer.cornerRadius = cornerRadius
        contentView.frame = bounds
        
        if isFullScreen {
            let template = ParallaxCardViewFullScreenTemplate()
            template.drawRect(rect: self.frame, imageView: imageView
                              , bottomContainerView: bottomContainerView)
        } else {
            let template = ParallaxCardViewTemplate()
            template.drawRect(rect: self.frame, imageView: imageView, bottomContainerView: bottomContainerView, parallaxVal: parallaxVal)
        }
        
        titleLabel.frame.origin = CGPoint(x: leftPadding, y: bottomContainerView.frame.height/2 - (titleLabel.frame.height + verticalPadding))
        titleLabel.frame.width = self.frame.width - 2*leftPadding
        subtitleLabel.frame.origin = CGPoint(x: leftPadding, y: bottomContainerView.frame.height/2 + 10.0)
        subtitleLabel.frame.width = self.frame.width - 2*leftPadding
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let cardViewInstance = ParallaxCardView(frame: self.frame)
        
        cardViewInstance.contentView.frame = self.contentView.frame
        
        if let image = self.imageView.image, let copyImage = image.cgImage?.copy() {
            let newImage = UIImage(cgImage: copyImage, scale: image.scale, orientation: image.imageOrientation)
            cardViewInstance.imageView.frame = self.imageView.frame
            cardViewInstance.imageView.image = newImage
        }
        
        cardViewInstance.bottomContainerView.frame = self.bottomContainerView.frame
        
        cardViewInstance.titleLabel.text = self.titleLabel.text
        cardViewInstance.titleLabel.frame = self.titleLabel.frame
        
        cardViewInstance.subtitleLabel.text = self.subtitleLabel.text
        cardViewInstance.subtitleLabel.frame = self.subtitleLabel.frame
        
        cardViewInstance.parallaxVal = parallaxVal
        
        return cardViewInstance
    }
    
    
}
