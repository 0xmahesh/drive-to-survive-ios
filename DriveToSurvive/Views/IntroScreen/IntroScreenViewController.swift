//
//  IntroScreenViewController.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 3/18/21.
//

import UIKit

class IntroScreenPageCollectionViewCell: UICollectionViewCell {
    weak var delegate: IntroScreenViewControllerDelegate?
}

protocol IntroScreenViewControllerDelegate : class {
    func nextButtonTapped()
    func skipButtonTapped()
}

class IntroScreenViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var pages: [UICollectionViewCell] = [UICollectionViewCell(), UICollectionViewCell()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "DiversityIntroPageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DiversityIntroPageCollectionViewCell")
        collectionView.isPagingEnabled = true
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }

}

extension IntroScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let page = self.pages[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiversityIntroPageCollectionViewCell", for: indexPath as IndexPath) as? IntroScreenPageCollectionViewCell {
            cell.delegate = self
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let diversityCell =  cell as? DiversityIntroPageCollectionViewCell {
            DispatchQueue.main.async {
                diversityCell.animateLabels()
            }
            
        }
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
