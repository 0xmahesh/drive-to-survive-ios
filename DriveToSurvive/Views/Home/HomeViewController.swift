//
//  HomeViewController.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 3/8/21.
//

import UIKit

protocol ParallaxCardViewManagerProtocol {
    var visibleCards: [ParallaxCardViewPresentable] { get }
    var selectedCardView: ParallaxCardViewPresentable? { get }
}

class HomeViewController: UIViewController, ParallaxCardViewManagerProtocol {

    @IBOutlet weak var newsCollectionView: UICollectionView!
    @IBOutlet weak var driverLineupCollectionView: UICollectionView!
    
    
    @IBOutlet weak var contentView: UIView!
    
    
    let margin: CGFloat = 30.0
    
    var listCellsize = CGSize.zero
    var detailCellSize = CGSize.zero
    var selectedCell: ParallaxCollectionViewCell?
    var collectionViewLayout: UICollectionViewLayout = ParallaxCollectionViewLayout()
    var newsItems: [NewsItem] = DataStore.shared.getNewsItems()
    var drivers: [Driver] = DataStore.shared.getDriversData()
    
    var lastOffsetX: CGFloat?
    
    var visibleCards: [ParallaxCardViewPresentable] {
        get {
            if let cells = newsCollectionView?.visibleCells {
                let cards = cells.map { $0 as! ParallaxCardViewPresentable }
                return cards
            }
            return [ParallaxCardViewPresentable]()
        }
    }
    
    var selectedCardView: ParallaxCardViewPresentable? {
        get {
            if let selectedCell = self.selectedCell as? ParallaxCardViewPresentable {
                return selectedCell
            }
            return nil
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsCollectionView.dataSource = self
        newsCollectionView.delegate = self
        newsCollectionView.register(ParallaxCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: ParallaxCollectionViewCell.reuseIdentifier)
        newsCollectionView.collectionViewLayout = self.collectionViewLayout
        
        driverLineupCollectionView.dataSource = self
        driverLineupCollectionView.delegate = self
        driverLineupCollectionView.register(UINib(nibName: DriverThumbnailCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: DriverThumbnailCollectionViewCell.reuseIdentifier)
        
        self.navigationController?.delegate = self
        
        setupUI()
        newsCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "metallic_gray")!)
        
        
        if let layout = self.collectionViewLayout as? ParallaxCollectionViewLayout {
            layout.minLineSpacing = 20.0
            layout.contentInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin - layout.minLineSpacing)
            layout.itemSize = CGSize(width: view.frame.width - (4*margin), height: 350)
            newsCollectionView.backgroundColor = .white
            newsCollectionView.layer.masksToBounds = false
            newsCollectionView.showsHorizontalScrollIndicator = false
        }
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        switch collectionView {
        case driverLineupCollectionView:
            return 1
        default:
            break
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case self.newsCollectionView:
            return newsItems.count
        case self.driverLineupCollectionView:
            return drivers.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case driverLineupCollectionView:
            return CGSize(width: UIScreen.main.bounds.width * 0.3, height: 0.2 * UIScreen.main.bounds.size.height)
        default:
            return .zero
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case driverLineupCollectionView:
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        default:
            return .zero
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell: UICollectionViewCell
        
        switch collectionView {
        case newsCollectionView:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: ParallaxCollectionViewCell.reuseIdentifier, for: indexPath)
            
            if let cell = cell as? ParallaxCollectionViewCell {
                let newsItem = self.newsItems[indexPath.row]
                cell.update(with: newsItem.image, title: newsItem.title, subtitle: newsItem.subtitle)
            }
        case driverLineupCollectionView:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: DriverThumbnailCollectionViewCell.reuseIdentifier, for: indexPath)
            
            if let driverCell = cell as? DriverThumbnailCollectionViewCell {
                let driver = self.drivers[indexPath.row]
                driverCell.update(with: driver)
            }
        default:
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case newsCollectionView:
            let newsItem = newsItems[indexPath.row]
            let newsDetailVC = NewsDetailViewController(with: newsItem)
            selectedCell = collectionView.cellForItem(at: indexPath) as! ParallaxCollectionViewCell?
            
            newsDetailVC.transitioningDelegate = self
            newsDetailVC.modalPresentationStyle = .custom
            present(newsDetailVC, animated: true, completion: nil)
          //  navigationController?.present(newsDetailVC, animated: true, completion: nil)
           // self.navigationController?.pushViewController(newsDetailVC, animated: true)
        default:
            break
        }
        
    }
    
    
    
}

extension HomeViewController : UICollectionViewDelegateFlowLayout {
    //UICollectionViewDelegateFlowLayout methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        switch collectionView {
        case driverLineupCollectionView:
            return 15
        default:
            break
        }
        
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        
        switch collectionView {
        case driverLineupCollectionView:
            return 15
        default:
            break
        }
        
        return 0
    }
}


extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomViewControllerTransition(isDismissed: false)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomViewControllerTransition(isDismissed: true)
    }
}


extension HomeViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .pop && fromVC is NewsDetailViewController {
            return CustomViewControllerTransition(isDismissed:  true)
        } else if operation == .pop {
            return nil
        }
        return CustomViewControllerTransition(isDismissed: false)
    }
}


extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == driverLineupCollectionView {
            animateDriverLineUp(scrollView: scrollView)
        }
        
      
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        lastOffsetX = nil
    }
    
    func animateDriverLineUp(scrollView: UIScrollView) {
        defer { lastOffsetX = scrollView.contentOffset.x }
        guard let lastOffsetX = lastOffsetX else { return }
        // You'll have to evaluate how large velocity gets to avoid the cells
        // from stretching too much
        let maxVelocity: CGFloat = 30
        let maxStretch: CGFloat = 20
        let velocity = min(scrollView.contentOffset.x - lastOffsetX, maxVelocity)
        let stretch = velocity / maxVelocity * maxStretch
        var cumulativeStretch: CGFloat = 0
          var delay: Double = 0
          
          for (index, cell) in driverLineupCollectionView.visibleCells.enumerated() {
              cumulativeStretch += stretch
              delay += 0.05 * Double(index)
              UIView.animate(withDuration: 0.2, delay: delay, options: [.curveEaseInOut, .layoutSubviews], animations: {
                  cell.transform = CGAffineTransform(translationX: -cumulativeStretch, y: 0)
              }, completion: nil)
          }
  //      collectionView.visibleCells.forEach { index, cell in
  //        cumulativeStretch += stretch
  //        delay += 0.1 *
  //        UIView.animate(withDuration: 0.2, delay: delay, options: [.curveEaseInOut, .layoutSubviews], animations: {
  //            cell.transform = CGAffineTransform(translationX: -cumulativeStretch, y: 0)
  //        }, completion: nil)
  //
         
  //      }
    }
}
