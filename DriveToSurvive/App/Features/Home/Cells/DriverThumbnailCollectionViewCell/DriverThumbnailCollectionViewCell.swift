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
                showName()
                UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
                    self.transform = self.transform.scaledBy(x: 0.95, y: 0.95)
                    self.nameWrapperView.transform = self.nameWrapperView.transform.scaledBy(x: 0.95, y: 1)
                               }, completion: nil)
            } else {
                hideName()
                UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
                    self.transform = .identity
                    self.nameWrapperView.transform = .identity
                               }, completion: nil)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
      
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowRadius = 10.0
//        self.layer.shadowOffset = CGSize(width: 0, height: 10)
//        self.layer.shadowOpacity = 0.3
//        //self.layer.cornerRadius = 10
//        self.layer.masksToBounds = false
        self.clipsToBounds = true
        
        self.nameLabelWrapperViewHeight.constant = 0
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
        
    }
    
    func showName() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveLinear, animations: {
            self.nameWrapperView.alpha = 1
            self.nameLabelWrapperViewHeight.constant = 50
            self.layoutIfNeeded()
        }, completion: nil)
    
    }
    
    func hideName() {
        self.nameWrapperView.alpha = 0
        self.nameLabelWrapperViewHeight.constant = 0
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveLinear, animations: {
//            self.nameWrapperView.alpha = 0
//            self.nameLabelWrapperViewHeight.constant = 0
//            self.layoutIfNeeded()
//        }, completion: nil)
    }
    

}
