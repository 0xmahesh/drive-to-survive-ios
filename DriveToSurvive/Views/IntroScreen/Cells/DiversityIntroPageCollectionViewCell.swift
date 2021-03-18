//
//  DiversityIntroPageCollectionViewCell.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 3/18/21.
//

import UIKit
import Lottie

class DiversityIntroPageCollectionViewCell: IntroScreenPageCollectionViewCell {
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var diversityLabel: UILabel!
    @IBOutlet weak var andLabel: UILabel!
    @IBOutlet weak var inclusionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var weRaceAsOneLabel: UILabel!
    @IBOutlet weak var animationView: AnimationView!
    
    
    /* constraints outlets */
    @IBOutlet weak var diversityLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var andLabelLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var inclusionLabelLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var descriptionLabelTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var weRaceAsOneTopLabelConstraint: NSLayoutConstraint!
    
    
    private let titleLabelLeadingPadding: CGFloat = 28.0
    private let descriptionLabelTopPadding: CGFloat = 50.0
    private let weRaceAsOneLabelTopPadding: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
      //  animateLabels()
    }
    
    private func setupUI() {
        animationView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        animationView.animationSpeed = 0.6
        animationView.loopMode = .loop
        
        diversityLabelLeadingConstraint.constant = -containerView.frame.size.width * 3/2
        andLabelLeadingConstraint.constant = -containerView.frame.size.width * 3/2
        inclusionLabelLeadingConstraint.constant =  -containerView.frame.size.width * 3/2
        descriptionLabelTopConstraint.constant += 300
        
        diversityLabel.alpha = 0
        andLabel.alpha = 0
        inclusionLabel.alpha = 0
        descriptionLabel.alpha = 0
        
        animationView.alpha = 0
        animationView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        weRaceAsOneLabel.alpha = 0
        weRaceAsOneLabel.frame.origin.y += 10
        
    }
    
    func animateLabels(withDelay delay: TimeInterval = 0) {
        
        let animationDuration: Double = 1.0
        let animation = UIViewPropertyAnimator(duration: animationDuration, curve: .easeInOut)
        animation.addAnimations {
          UIView.animateKeyframes(withDuration: animationDuration, delay: 0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                self.diversityLabelLeadingConstraint.constant = self.titleLabelLeadingPadding
                self.diversityLabel.alpha = 1
                self.layoutIfNeeded()
            })
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 1, animations: {
                self.andLabelLeadingConstraint.constant = self.titleLabelLeadingPadding
                self.andLabel.alpha = 1
                self.descriptionLabelTopConstraint.constant = self.descriptionLabelTopPadding
                self.descriptionLabel.alpha = 1
                self.layoutIfNeeded()
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 1, animations: {
                self.inclusionLabelLeadingConstraint.constant = self.titleLabelLeadingPadding
                self.inclusionLabel.alpha = 1
                self.layoutIfNeeded()
            })
          }, completion: { completed in
            
            UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 0.9, initialSpringVelocity: 3, options: [.curveEaseInOut], animations: {
                self.animationView.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
                self.animationView.alpha = 1
                
                UIView.animate(withDuration: 0.2, delay: 0.4, options: [.curveEaseInOut], animations: {
                    self.weRaceAsOneLabel.alpha = 1
                    self.weRaceAsOneTopLabelConstraint.constant = self.weRaceAsOneLabelTopPadding
                }, completion: nil)
                
            }, completion: { completed in
                self.animationView.play()
            })
          })
        }
        animation.startAnimation(afterDelay: delay)
        
    }

}
