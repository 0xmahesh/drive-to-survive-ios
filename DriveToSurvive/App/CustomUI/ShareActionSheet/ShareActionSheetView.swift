//
//  ShareActionSheetView.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 3/28/21.
//

import UIKit

protocol ShareActionSheetViewDelegate: class {
    func facebookButtonTapped()
    func instagramButtonTapped()
    func twitterButtonTapped()
    func snapchatButtonTapped()
}

class ShareActionSheetView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var sheetView: UIView!
    @IBOutlet weak var bgview: UIView!
    @IBOutlet weak var shareLabel: UILabel!
    
    @IBOutlet weak var sheetViewHeight: NSLayoutConstraint!
    
    weak var delegate: ShareActionSheetViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ShareActionSheetView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        sheetView.clipsToBounds = true
        sheetView.layer.cornerRadius = 20
        sheetView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
          
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        contentView.addGestureRecognizer(tapGesture)
        
        
        sheetViewHeight.constant = 0
    }
    
    @objc private func didTap(sender: UITapGestureRecognizer) {
        hide()
    }
    
    func hide() {
        self.sheetViewHeight.constant = 0
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: [.curveEaseInOut, .layoutSubviews], animations: { [weak self] in
                self?.layoutIfNeeded()
        }, completion: { completed in
            self.removeFromSuperview()
        })
    }
    
    public func show() {
        sheetViewHeight.constant = 200
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: [.curveEaseInOut, .layoutSubviews], animations: { [weak self] in
            self?.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        hide()
    }
    
    @IBAction func facebookButtonTapped(_ sender: Any) {
        delegate?.facebookButtonTapped()
    }
    
    @IBAction func instagramButtonTapped(_ sender: Any) {
        delegate?.instagramButtonTapped()
    }
    
    @IBAction func TwitterButtonTapped(_ sender: Any) {
        delegate?.twitterButtonTapped()
    }
    
    @IBAction func snapChatButtonTapped(_ sender: Any) {
        delegate?.snapchatButtonTapped()
    }
    
    

}
