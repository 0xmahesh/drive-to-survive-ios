//
//  DriverThumbnailCollectionViewCell.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 3/14/21.
//

import UIKit

class DriverThumbnailCollectionViewCell: UICollectionViewCell {
    
    public static let reuseIdentifier = "DriverThumbnailCollectionViewCell"
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var nameWrapperView: UIView!
    @IBOutlet weak var nameLabelWrapperViewHeight: NSLayoutConstraint!
    
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
               // hideName()
                UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
                    self.transform = self.transform.scaledBy(x: 0.95, y: 0.95)
                               }, completion: nil)
            } else {
               // showName()
                UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
                               }, completion: nil)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
        UIView.animate(withDuration: 0.3, animations: {
            self.nameLabelWrapperViewHeight.constant = 50.0
           // self.nameWrapperView.alpha = 1
        }, completion: nil)
    }
    
    func hideName() {
        //nameWrapperView.alpha = 1
        UIView.animate(withDuration: 0.3, animations: {
            self.nameLabelWrapperViewHeight.constant = 0
           // self.nameWrapperView.alpha = 0
        }, completion: nil)
    }
    

}
