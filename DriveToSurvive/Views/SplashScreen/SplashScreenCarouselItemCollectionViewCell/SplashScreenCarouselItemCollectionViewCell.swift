//
//  SplashScreenCarouselItemCollectionViewCell.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 2/22/21.
//

import UIKit

class SplashScreenCarouselItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageViewParent: UIView!
    
    
    var hasStretched: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     //   print("cell awake from nib")
    }
    
    func animate(with stretch: CGFloat) {
        if hasStretched { return }
        
        if stretch > 0 {
            UIView.animate(withDuration: 0.1, delay: 0.3, options: [.curveEaseInOut], animations: {
                
                if(self.trailingConstraint.constant <= 30) {
                    self.trailingConstraint.constant +=  stretch
                } else {
                    UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseInOut], animations: {
                        self.trailingConstraint.constant = 5
                    }, completion: nil)
                }
                
            }, completion: { completed in
                self.hasStretched = true
            })
        } else {
            UIView.animate(withDuration: 0.1, delay: 0.3, options: [.curveEaseInOut], animations: {
                if(self.leadingConstraint.constant <= 30) {
                    self.leadingConstraint.constant +=  stretch
                } else {
                    UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseInOut], animations: {
                        self.leadingConstraint.constant = 5
                    }, completion: nil)
                }
            }, completion: { completed in
                self.hasStretched = true
            })
        }
    }
    
    func resetAnimation() {
        hasStretched = false
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            self.leadingConstraint.constant = 5
            self.trailingConstraint.constant = 5
        }, completion: nil)
        
    }
    
    override func prepareForReuse() {
        self.hasStretched = false
    }

}
