//
//  IntroScreenViewController.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 3/18/21.
//

import UIKit

protocol IntroScreenPageCollectionViewCellAnimatable: class {
    func animateLabels(withDelay delay: TimeInterval)
}

class IntroScreenPageCollectionViewCell: UICollectionViewCell  {
    weak var delegate: IntroScreenViewControllerDelegate?
    func animateLabels(withDelay delay: TimeInterval) {}
    func stopAnimations() {}
}

protocol IntroScreenViewControllerDelegate : class {
    func nextButtonTapped()
    func skipButtonTapped()
}

class IntroScreenViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var launchButton: TransitionButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    private var pages: Int = 3
    
    private var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLaunchButton()
        setupCollectionView()
        pageControl.backgroundStyle = .minimal
        pageControl.pageIndicatorTintColor = UIColor(hex: "e5e5e5")
        pageControl.currentPageIndicatorTintColor = .gray
    }
    
    private func setupLaunchButton() {
        launchButton.backgroundColor = UIColor.black
        launchButton.setTitle("Launch", for: .normal)
        launchButton.setTitle("Launch", for: .highlighted)
        launchButton.setTitleColor(.white, for: .normal)
        launchButton.setTitleColor(UIColor(hex: "e5e5e5"), for: .highlighted)
        launchButton.cornerRadius = launchButton.frame.height/2
        launchButton.spinnerColor = .white
        launchButton.titleLabel?.font = UIFont(name: "Formula1-Display-Bold", size: 18.0)
        launchButton.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        launchButton.transform = CGAffineTransform(translationX: 0, y: 25.0)
        launchButton.alpha = 0
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "DiversityIntroPageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DiversityIntroPageCollectionViewCell")
        collectionView.register(UINib(nibName: "SustainabilityIntroPageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SustainabilityIntroPageCollectionViewCell")
        collectionView.register(UINib(nibName: "CommunityIntroPageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CommunityIntroPageCollectionViewCell")
        collectionView.isPagingEnabled = true
        collectionView.collectionViewLayout = self.collectionViewFlowLayout
        collectionView.bounces = false
    }
    
    @IBAction func launchButtonTapped(_ sender: TransitionButton) {
        launchButton.startAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            
            
            
            
            self.launchButton.stopAnimation(animationStyle: .expand, completion: {
                let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                guard let window = appDelegate.window else {
                    return
                }
                window.rootViewController = homeVC
                let options: UIView.AnimationOptions = .transitionCrossDissolve
                let duration: TimeInterval = 0.3
                UIView.transition(with: window, duration: duration, options: options, animations: {}, completion:
                { completed in

                })
                
            })
        })
    }
    
    
    private func showLaunchButton() {
        UIView.animate(withDuration: 0.8, delay: 1.5, options: .curveEaseInOut, animations: {
            self.launchButton.transform = .identity
            self.launchButton.alpha = 1
        }, completion: nil)
    }

}

extension IntroScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.pages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case 0:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiversityIntroPageCollectionViewCell", for: indexPath as IndexPath) as? IntroScreenPageCollectionViewCell {
                cell.delegate = self
                
                return cell
            }
        case 1:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SustainabilityIntroPageCollectionViewCell", for: indexPath as IndexPath) as? IntroScreenPageCollectionViewCell {
                cell.delegate = self
                
                return cell
            }
        case 2:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommunityIntroPageCollectionViewCell", for: indexPath as IndexPath) as? IntroScreenPageCollectionViewCell {
                cell.delegate = self
                
                return cell
            }
        default:
            break
        }
        
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell =  cell as? IntroScreenPageCollectionViewCell {
            DispatchQueue.main.async {
                cell.animateLabels(withDelay: 0.3)
                if indexPath.row == self.pages-1 {
                    self.showLaunchButton()
                }
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell =  cell as? IntroScreenPageCollectionViewCell {
            DispatchQueue.main.async {
                cell.stopAnimations()
            }
            
        }
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page : Int = Int(round(scrollView.contentOffset.x / collectionView.frame.width))
        pageControl.currentPage = page
        
    }
    
}

extension IntroScreenViewController: IntroScreenViewControllerDelegate {
    func nextButtonTapped() {
        print("next button tapped")
    }
    
    func skipButtonTapped() {
        print("skip button tapped")
    }
    
    
}
