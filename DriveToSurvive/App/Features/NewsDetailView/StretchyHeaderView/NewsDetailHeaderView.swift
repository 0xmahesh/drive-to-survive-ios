//
//  NewsDetailHeaderView.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 3/27/21.
//

import UIKit

class NewsDetailHeaderView: UIView {

    static let reuseIdentifier: String = "NewsDetailHeaderView"
    
    private var newsItem: NewsItem?
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView(image: self.newsItem?.image)
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        return iv
    }()
    
    //var animator: UIViewPropertyAnimator!
    var visualEffectView =  UIVisualEffectView(effect: nil)
    let animator = UIViewPropertyAnimator(duration: 0.4, curve: .linear)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(with newsItem: NewsItem, frame: CGRect) {
        self.init(frame: frame)
        self.newsItem = newsItem
        self.addSubview(imageView)
        imageView.fillSuperview()
        setupVisualEffectBlur()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    
    public func setupVisualEffectBlur() {
        self.addSubview(visualEffectView)
        animator.addAnimations {
            self.visualEffectView.effect = UIBlurEffect(style: .regular)
        }
        
        animator.pausesOnCompletion = true
        animator.startAnimation()
        animator.pauseAnimation()
        animator.fractionComplete = 0
        visualEffectView.fillSuperview()
    }
    
}
