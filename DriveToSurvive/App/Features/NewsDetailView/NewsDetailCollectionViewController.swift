//
//  NewsDetailCollectionViewController.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 3/26/21.
//

import UIKit

protocol SwipeToDismissable {
    var swipeVelocityThreshold: CGFloat { get }
    func onSwipe(in vc: UIViewController, sender: UIPanGestureRecognizer)
}

extension SwipeToDismissable {
    
    var swipeVelocityThreshold: CGFloat {
        return 300
    }
    
    func onSwipe(in vc: UIViewController, sender: UIPanGestureRecognizer) {
        guard let view = vc.view else { return }
        let velocity = sender.velocity(in: view)
        if velocity.y < 0 {
             return
        }
        let touchPoint = sender.location(in: view.window)
        var initialTouchPoint = CGPoint.zero

        switch sender.state {
        case .began:
            initialTouchPoint = touchPoint
        case .changed:
            if touchPoint.y > initialTouchPoint.y {
                view.frame.origin.y = touchPoint.y - initialTouchPoint.y
            }
        case .ended, .cancelled:
            if touchPoint.y - initialTouchPoint.y > swipeVelocityThreshold {
                vc.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveEaseInOut, animations: {
                    view.frame = CGRect(x: 0,
                                             y: 0,
                                             width: view.frame.size.width,
                                             height: view.frame.size.height)
                }, completion: nil)
            }
        case .failed, .possible:
            break
        @unknown default:
            break
        }
    }
}

class NewsDetailCollectionViewController: UICollectionViewController, SwipeToDismissable {
    
    private let cellReuseIdentifier = "NewsDetailCell"
    private let padding: CGFloat = 20
    
    private var stickyHeaderView = NewsDetailHeaderView()
    private var shareActionSheet: ShareActionSheetView?
    var navBarHeight: CGFloat = 44
    var newsItem: NewsItem?
    let buttonStackView = UIStackView()
    var isHorizontalButtonStackView: Bool = false
    var isVerticalButtonStackView: Bool = true
    var isAnimating: Bool = false
    var vMaskLayer : CAGradientLayer = CAGradientLayer()
    
    convenience init(with news: NewsItem, layout: UICollectionViewFlowLayout) {
        self.init(collectionViewLayout: layout)
        self.newsItem = news
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderView()
        setupCollectionView()
        setupCollectionViewFlowLayout()
        setupButtonStackView()
        
        collectionView.contentInset = UIEdgeInsets(top: stickyHeaderView.bounds.height, left: 0, bottom: 0, right: 0)
        
        setupSwipeToDismiss()
        
        
        let descriptionHeight = getLabelHeight(for: newsItem?.description ?? "", font: UIFont(name: "Avenir-Roman", size: 18)!, padding: 2*20)
        if(descriptionHeight > view.frame.height/2) {
            addReadMoreGradient()
        }
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        vMaskLayer.removeFromSuperlayer()
    }
    
    fileprivate func setupSwipeToDismiss() {
        let gestureRecognizer = UIPanGestureRecognizer(target: self,
                                                       action: #selector(panGestureRecognizerHandler(_:)))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    fileprivate func addReadMoreGradient() {
        var innerColor: CGColor
        if traitCollection.userInterfaceStyle == .dark {
            innerColor = UIColor(white: 1.0, alpha: 0.8).cgColor
        } else {
            innerColor = UIColor.black.withAlphaComponent(0.8).cgColor
        }
        
        let outerColor = UIColor(white: 1.0, alpha: 0.0).cgColor;

        let colors = [outerColor, innerColor]
        let locations: [NSNumber] = [0.92, 1.0]
        
        vMaskLayer.opacity = 0.6
        vMaskLayer.colors = colors;
        vMaskLayer.locations = locations;
        vMaskLayer.bounds = self.collectionView.bounds;
        vMaskLayer.anchorPoint = .zero;

        self.view.layer.addSublayer(vMaskLayer)
    }
    
    private func createShareActionSheet() {
        shareActionSheet = ShareActionSheetView(frame: CGRect(origin: .zero, size: self.view.frame.size))
        self.view.addSubview(shareActionSheet!)
    }
    
    @IBAction func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        onSwipe(in: self, sender: sender)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        
        var buttonStackTopPadding: CGFloat = 0
        if UIDevice.current.hasNotch {
            buttonStackTopPadding = view.safeAreaInsets.top
        }
        
        buttonStackView.frame.origin.y = buttonStackTopPadding
        navBarHeight = view.safeAreaInsets.top + 44
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! NewsDetailCollectionViewCell
        if let newsItem = self.newsItem {
            cell.initCell(type: .text, newsItem: newsItem)
        }
       
        return cell
    }
    
    fileprivate func setupCollectionView() {
        
        if traitCollection.userInterfaceStyle == .dark {
            collectionView.backgroundColor = .black
        } else {
            collectionView.backgroundColor = .white
        }
        
        self.collectionView.register(UINib(nibName: "NewsDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: NewsDetailCollectionViewCell.reuseIdentifier)
        self.collectionView.register(NewsDetailHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NewsDetailHeaderView.reuseIdentifier)
        collectionView.contentInsetAdjustmentBehavior = .never
    }
    
    fileprivate func setupCollectionViewFlowLayout() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = .init(top: 0, left: padding, bottom: 10, right: padding)
            layout.sectionHeadersPinToVisibleBounds = true
            
        }
    }
    
    fileprivate func setupButtonStackView() {
        let closeButton = UIButton(type: .custom)
        closeButton.frame = CGRect(origin: .zero, size: CGSize(width: 30, height: 30))
        closeButton.setImage(UIImage(named:"close-white"), for: .normal)
        closeButton.setImage(UIImage(named:"close-gray"), for: .highlighted)
        closeButton.contentMode = .center
        closeButton.addTarget(self, action:#selector(closeButtonTapped(sender:)), for: .touchUpInside)
        
        let shareButton = UIButton(type: .custom)
        shareButton.frame = CGRect(origin: .zero, size: CGSize(width: 30, height: 30))
        shareButton.setImage(UIImage(named:"share"), for: .normal)
        shareButton.setImage(UIImage(named:"share-black"), for: .highlighted)
        shareButton.contentMode = .center
        shareButton.addTarget(self, action:#selector(shareButtonTapped(sender:)), for: .touchUpInside)
        
        let bookmarkButton = UIButton(type: .custom)
        bookmarkButton.frame = CGRect(origin: .zero, size: CGSize(width: 30, height: 30))
        bookmarkButton.setImage(UIImage(named:"bookmark"), for: .normal)
        bookmarkButton.setImage(UIImage(named:"bookmark-black"), for: .highlighted)
        bookmarkButton.contentMode = .center
        
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 10
        buttonStackView.distribution = .fillEqually
        buttonStackView.alignment = .center
        
        buttonStackView.frame = CGRect(x: view.frame.width-40, y: navBarHeight/2 - 15, width: 30, height: 110)
        self.view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(closeButton)
        buttonStackView.addArrangedSubview(shareButton)
        buttonStackView.addArrangedSubview(bookmarkButton)
    }
    
    fileprivate func setupHeaderView() {
        guard let newsItem = self.newsItem else { return }
        stickyHeaderView = NewsDetailHeaderView(with: newsItem, frame:  CGRect.init(x:0, y:0 , width: view.bounds.width, height: view.bounds.height * 0.5))
        view.addSubview(stickyHeaderView)
    }
    
    @objc private func closeButtonTapped(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func shareButtonTapped(sender: UIButton) {
        createShareActionSheet()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.shareActionSheet?.show()
        })
    }
    
    @objc private func animateStackView(isHorizontal: Bool) {
        self.isAnimating = true
        if isHorizontal {
            let currentButtonStackViewWidth = buttonStackView.frame.width
            let currentButtonStackViewHeight = buttonStackView.frame.height
            let currentButtonStackViewMaxX = buttonStackView.frame.maxX
            let currentButtonStackViewY = buttonStackView.frame.origin.y
            UIView.animate(withDuration: 0.5, animations: {
                self.buttonStackView.axis = .horizontal
                self.buttonStackView.addArrangedSubview(self.buttonStackView.subviews[2])
                self.buttonStackView.addArrangedSubview(self.buttonStackView.subviews[1])
                self.buttonStackView.addArrangedSubview(self.buttonStackView.subviews[0])
                
                self.buttonStackView.frame = CGRect(x: currentButtonStackViewMaxX-currentButtonStackViewHeight, y: currentButtonStackViewY, width: currentButtonStackViewHeight, height: currentButtonStackViewWidth)
                self.buttonStackView.layoutIfNeeded()
            }, completion:  { completed in
                self.isHorizontalButtonStackView = true
                self.isVerticalButtonStackView = false
                self.isAnimating = false
                
            })
        } else {
            let currentButtonStackViewWidth = buttonStackView.frame.width
            let currentButtonStackViewHeight = buttonStackView.frame.height
            let currentButtonStackViewY = buttonStackView.frame.origin.y
            UIView.animate(withDuration: 1, animations: {
                self.buttonStackView.axis = .vertical
                self.buttonStackView.addArrangedSubview(self.buttonStackView.subviews[0])
                self.buttonStackView.addArrangedSubview(self.buttonStackView.subviews[1])
                self.buttonStackView.addArrangedSubview(self.buttonStackView.subviews[2])
                
                self.buttonStackView.frame = CGRect(x: self.view.frame.width-40, y: currentButtonStackViewY, width: currentButtonStackViewHeight, height: currentButtonStackViewWidth)
                self.buttonStackView.layoutIfNeeded()
            }, completion:  { completed in
                self.isHorizontalButtonStackView = false
                self.isVerticalButtonStackView = true
                self.isAnimating = false
            })
        }
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        vMaskLayer.removeFromSuperlayer()
        
        let scrollViewOffset = scrollView.contentOffset.y
        print("Y offset: \(scrollViewOffset)")
        let totalOffset = scrollViewOffset + stickyHeaderView.bounds.height
        var headerTransform = CATransform3DIdentity // Both Scale and Translate.
        
        if totalOffset < 0 {
            let headerScaleFactor:CGFloat = -(totalOffset) / stickyHeaderView.bounds.height
            let headerSizevariation = ((stickyHeaderView.bounds.height * (1.0 + headerScaleFactor)) - stickyHeaderView.bounds.height)/2
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
        } else {
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-(stickyHeaderView.bounds.height-navBarHeight), -totalOffset), 0)
        }
        
        stickyHeaderView.layer.transform = headerTransform
        
        if scrollViewOffset > -(view.frame.height/2) {
            let blurVal =  abs(1 - abs(scrollViewOffset)/stickyHeaderView.frame.height)
            stickyHeaderView.animator.fractionComplete = blurVal
        } else {
            stickyHeaderView.animator.fractionComplete = 0
        }
        
        
        if !isHorizontalButtonStackView && scrollViewOffset >= -(stickyHeaderView.bounds.height/2) && !isAnimating{
            animateStackView(isHorizontal: true)
        }
        
        if !isVerticalButtonStackView && scrollViewOffset <= -(stickyHeaderView.bounds.height/2 + 1) && !isAnimating {
            animateStackView(isHorizontal: false)
        }
        
        
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        stickyHeaderView.animator.stopAnimation(true)
    }
    
}


//MARK :- FlowLayout Methods

extension NewsDetailCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var totalEstimatedHeight: CGFloat = 0
        
        if let newsItem = newsItem {
            let titleLabelHeight = getLabelHeight(for: newsItem.title, font: UIFont(name: "Formula1-Display-Bold", size: 20)!, padding: 2*20)
            let timestampLabelHeight = getLabelHeight(for: "26th March 2021, 18:57 GMT", font: UIFont(name: "Avenir-Roman", size: 12)!, padding: 2*20)
            let descriptionLabelHeight = getLabelHeight(for: newsItem.description, font: UIFont(name: "Avenir-Roman", size: 18)!, padding: 2*20)
            let verticalPadding = NewsDetailCollectionViewCell.getCumulativeCellPadding()
            totalEstimatedHeight = titleLabelHeight + timestampLabelHeight + descriptionLabelHeight + verticalPadding
        }
        return .init(width: view.frame.width, height: totalEstimatedHeight)
    }
    
    private func getLabelHeight(for text: String, font: UIFont, padding: CGFloat) -> CGFloat {
        let approxWidthOfTitleLabel = view.frame.width - padding
        let approxSizeOfTitleLabel = CGSize(width: approxWidthOfTitleLabel, height: 1000)
        let titleLabelAttributes = [NSAttributedString.Key.font: font]
        let estimatedTitleLabelFrame = NSString(string: text).boundingRect(with: approxSizeOfTitleLabel, options: .usesLineFragmentOrigin, attributes: titleLabelAttributes as [NSAttributedString.Key : Any], context: nil)
        return estimatedTitleLabelFrame.height
    }
}
