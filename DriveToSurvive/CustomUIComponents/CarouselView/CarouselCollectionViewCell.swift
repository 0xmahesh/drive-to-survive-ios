//
//  CarouselCollectionViewCell.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 2/13/21.
//

import UIKit

//Protocol to inform that cell is being swiped up or down.
public protocol CarouselDelegate : class {
    func cellSwipedUp(_ cell: UICollectionViewCell)
    func cellSwipedDown(_ cell: UICollectionViewCell)
}

open class CarouselCollectionViewCell: UICollectionViewCell {
    public weak var delegate: CarouselDelegate?
    public var deleteOnSwipeUp = false
    public var deleteOnSwipeDown = false
    private var cellManager: CarouselViewManager!
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        //Init the Cell Manager
        cellManager = CarouselViewManager(withCell: self)
        // Add Gesture to Cell
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:))))
    }
    
    @objc private func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        cellManager.handlePanGesture(sender)
    }
}
