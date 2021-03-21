//
//  CommunityIntroPageCollectionViewCell.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 3/20/21.
//

import UIKit
import Lottie

class CommunityIntroPageCollectionViewCell: IntroScreenPageCollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var communityImageview: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    /* constraints outlets */
    @IBOutlet weak var titleLabelTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var descriptionLabelTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var communityImageViewLeadingConstraint: NSLayoutConstraint!
    
    private let kTitleLabelTopPadding: CGFloat = 92.0
    private let kDescriptionLabelTopPadding: CGFloat = 50.0
    private let kImageViewLeadingPadding: CGFloat = -25.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        animationView.animationSpeed = 1
        animationView.loopMode = .loop
        
        titleLabelTopConstraint.constant += 300
        descriptionLabelTopConstraint.constant += 300
        communityImageViewLeadingConstraint.constant -= communityImageview.frame.size.width
        
        titleLabel.alpha = 0
        animationView.alpha = 0
        subtitleLabel.alpha = 0
        descriptionLabel.alpha = 0
        communityImageview.alpha = 0

        communityImageview.fadeBorders()
    }
    
    override func animateLabels(withDelay delay: TimeInterval = 0) {
        let animationDuration: Double = 1.0
        let animation = UIViewPropertyAnimator(duration: animationDuration, curve: .easeInOut)
        animation.addAnimations {
          UIView.animateKeyframes(withDuration: animationDuration, delay: 0, animations: {
            self.communityImageview.alpha = 1
            self.communityImageViewLeadingConstraint.constant = self.kImageViewLeadingPadding
            self.layoutIfNeeded()
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                self.titleLabelTopConstraint.constant = self.kTitleLabelTopPadding
                self.titleLabel.alpha = 1
                self.layoutIfNeeded()
            })
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 1, animations: {
                self.descriptionLabelTopConstraint.constant = self.kDescriptionLabelTopPadding
                self.descriptionLabel.alpha = 1
                self.layoutIfNeeded()
            })
            
          }, completion: { completed in
            
            self.animationView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.animationView.alpha = 1
            self.animationView.play()

          })
        }
        animation.startAnimation(afterDelay: delay)
    }
    
    override func stopAnimations() {
        animationView.stop()
    }

}


