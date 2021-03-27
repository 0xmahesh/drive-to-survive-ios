//
//  DriverThumbnailCollectionViewCell.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 3/14/21.
//

import UIKit

class DriverThumbnailCollectionViewCell: UICollectionViewCell {
    
    public static let reuseIdentifier = "DriverThumbnailCollectionViewCell"
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var nameWrapperView: UIView!
    @IBOutlet weak var nameLabelWrapperViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var nameLabelWrapperViewTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var nameLabelWrapperViewLeading: NSLayoutConstraint!
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                hideName()
                UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
                    self.transform = self.transform.scaledBy(x: 0.95, y: 0.95)
                               }, completion: nil)
            } else {
                showName()
                UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
                               }, completion: nil)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
      
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 10.0
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.layer.shadowOpacity = 0.1
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        self.nameLabelWrapperViewHeight.constant = 50
    }
    
    override func layoutSubviews() {
        if let image = thumbnailImageView.image {
            let imageSize = image.size
            let padding =  (thumbnailImageView.frame.width - imageSize.width)/2
            nameLabelWrapperViewLeading.constant = padding
            nameLabelWrapperViewTrailing.constant = padding
        }
        
    }
    
    func update(with driver: Driver) {
        firstName.text = driver.firstName
        lastName.text = driver.lastName
        if let imageUrl = driver.imageUrl {
            thumbnailImageView.image = UIImage(named: imageUrl)
        }
        showName()
        
    }
    
    func showName() {
       // nameWrapperView.alpha = 0
        //self.nameLabelWrapperViewHeight.constant = 50.0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveLinear, animations: {
            self.nameWrapperView.alpha = 1
            self.nameLabelWrapperViewHeight.constant = 50
            self.layoutIfNeeded()
        }, completion: nil)
    
    }
    
    func hideName() {
        //nameWrapperView.alpha = 1
        //self.nameLabelWrapperViewHeight.constant = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveLinear, animations: {
            self.nameWrapperView.alpha = 0
            self.nameLabelWrapperViewHeight.constant = 0
            self.layoutIfNeeded()
        }, completion: nil)
    }
    

}
