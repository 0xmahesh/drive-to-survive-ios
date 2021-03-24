//
//  NewsDetailViewController.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 3/9/21.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    private var newsItem: NewsItem
    
    lazy var cardView: ParallaxCardView = {
        let cardView = ParallaxCardView(frame: .zero)
        cardView.isFullScreen = true
        cardView.cornerRadius = 0.0
        cardView.imageHeightRatio = 0.5
        cardView.offset = 0
        cardView.imageView.image = newsItem.image
        cardView.layoutSubviews()
        return cardView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        return scrollView
    }()
    
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
        view.backgroundColor = UIColor.white
        scrollView.frame = view.frame
        cardView.frame.size = view.frame.size
        view.addSubview(scrollView)
        scrollView.addSubview(cardView)
        
        
        /* test view */
        let secondView = UIView()
        secondView.frame = CGRect(origin: CGPoint(x: 0, y: cardView.frame.height), size: CGSize(width: scrollView.frame.width, height: 1000))
        secondView.backgroundColor = .red
       // scrollView.addSubview(secondView)
        
        let contentWidth = scrollView.frame.width
        let contentHeight = cardView.frame.size.height + 100
            //+ secondView.frame.size.height
        
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        scrollView.setContentOffset(CGPoint(x: 0, y: 47), animated: false)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      super.touchesBegan(touches, with: event)
      
      dismiss(animated: true, completion: nil)
    }

}


extension NewsDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("content offset: \(scrollView.contentOffset)")
    }
}
