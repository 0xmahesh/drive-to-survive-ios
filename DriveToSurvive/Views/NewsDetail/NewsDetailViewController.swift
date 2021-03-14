//
//  NewsDetailViewController.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 3/9/21.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    private var newsItem: NewsItem
    
    var cardView = ParallaxCardView(frame: .zero)
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    init(with item: NewsItem) {
        self.newsItem = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardView.frame.size = view.bounds.size
        cardView.isFullScreen = true
        cardView.cornerRadius = 0.0
        cardView.imageHeightRatio = 0.5
        cardView.offset = 0
        cardView.imageView.image = newsItem.image
        
        view.addSubview(cardView)
        cardView.layoutSubviews()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      super.touchesBegan(touches, with: event)
      
      dismiss(animated: true, completion: nil)
    }

}
