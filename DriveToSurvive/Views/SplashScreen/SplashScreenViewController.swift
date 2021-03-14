//
//  SplashScreenViewController.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 2/10/21.
//

import UIKit

let reuseIdentifier = "CellIdentifer"

class SplashScreenViewController: UIViewController, UICollectionViewDelegate,
                                  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var lastOffsetX: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let nib = UINib(nibName: "SplashScreenCarouselItemCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "SplashScreenCarouselItemCollectionViewCell")
        
        collectionView.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UICollectionViewDelegateFlowLayout methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        
        return 15;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        
        return 15;
    }
    
    
    //UICollectionViewDatasource methods
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SplashScreenCarouselItemCollectionViewCell", for: indexPath) as! SplashScreenCarouselItemCollectionViewCell
        
      //  cell.backgroundColor = UIColor.gray
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width * 0.3, height: 0.2 * UIScreen.main.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        defer { lastOffsetX = scrollView.contentOffset.x }
//        guard let lastOffsetX = lastOffsetX else { return }
//        // You'll have to evaluate how large velocity gets to avoid the cells
//        // from stretching too much
//        let maxVelocity: CGFloat = 60
//        let maxStretch: CGFloat = 15
//        let velocity = min(scrollView.contentOffset.x - lastOffsetX, maxVelocity)
//        //    print ("velocity \(velocity)")
//        let stretch = velocity / maxVelocity * maxStretch
//        var cumulativeStretch: CGFloat = 0
//
//        collectionView.visibleCells.forEach { cell in
//            cumulativeStretch += stretch
//            print("stretch :\(cumulativeStretch)")
//
//            UIView.animate(withDuration: 0.2, delay: 0.3, options: .curveLinear, animations: {
//                //            (cell as! SplashScreenCarouselItemCollectionViewCell).imageViewParent.transform = CGAffineTransform(translationX: -cumulativeStretch, y: 0)
//                (cell as! SplashScreenCarouselItemCollectionViewCell).imageViewParent.transform = CGAffineTransform(scaleX: 0.7, y: 1)
//            }, completion: { completed in
//                UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
//                    (cell as! SplashScreenCarouselItemCollectionViewCell).imageViewParent.transform = CGAffineTransform(scaleX: 1, y: 1)
//                }, completion: nil)
//
//            })
//
//            //  (cell as! SplashScreenCarouselItemCollectionViewCell).animate(with: stretch)
//            //        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5.0, options: .curveEaseInOut, animations: {
//            //            cell.transform = CGAffineTransform(translationX: cumulativeStretch, y: 0)
//            //        }, completion: nil)
//            //        UIView.animate(withDuration: 0.3, animations: {
//            //            cell.transform = CGAffineTransform(translationX: cumulativeStretch, y: 0)
//            //        })
//
//        }
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
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
        
        for (index, cell) in collectionView.visibleCells.enumerated() {
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        lastOffsetX = nil
        
//        collectionView.visibleCells.forEach { cell in
//            (cell as! SplashScreenCarouselItemCollectionViewCell).hasStretched = false
//        }
        
    }
    
    @IBAction func launchButtonTapped(_ sender: Any) {
        let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
        self.present(homeVC, animated: true, completion: nil)
        //self.navigationController?.pushViewController(homeVC, animated: true)
    }
    
    
}
