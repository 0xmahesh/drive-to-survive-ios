//
//  DriverDetailViewControllerTransitionAnimator.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 3/14/21.
//

import UIKit

class DriverDetailViewControllerTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private var isDismissed: Bool = false
    
    private var cellImageViewRect: CGRect = .zero
    
    private var selectedImageViewSnapshot: UIView?
    
    init(isDismissed: Bool) {
        self.isDismissed = isDismissed
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isDismissed {
            dismiss(transitionContext: transitionContext)
        } else {
            present(transitionContext: transitionContext)
        }
    }
    
    private func dismiss(transitionContext: UIViewControllerContextTransitioning) {
        
    }
    
    private func present(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVC = transitionContext.viewController(forKey: .from) as? HomeViewController else { return }
        guard let toVC = transitionContext.viewController(forKey: .to) as? DriverDetailViewController else { return }
        guard let window = fromVC.view.window ?? toVC.view.window,
              let selectedCell = fromVC.selectedDriverCell
                    else { return }
        
        
        let containerView = transitionContext.containerView
        
        guard let toView = toVC.view else {
            transitionContext.completeTransition(false)
            return
        }
        
        let backgroundView: UIView
        let fadeView = UIView(frame: containerView.bounds)
        fadeView.backgroundColor = toView.backgroundColor
      
        guard let selectedDriverCellImageSnapshot = fromVC.selectedDriverCell?.thumbnailImageView.snapshotView(afterScreenUpdates: true),
              let detailViewImageSnapshot = toVC.driverImageView.snapshotView(afterScreenUpdates: true) else {
            transitionContext.completeTransition(true)
            return
        }
        
        let duration = transitionDuration(using: transitionContext)
        
        self.cellImageViewRect = selectedCell.thumbnailImageView.convert(selectedCell.thumbnailImageView.bounds, to: window)
        
        if isDismissed {
            backgroundView = fromVC.view.snapshotView(afterScreenUpdates: true) ?? fadeView
                        backgroundView.addSubview(fadeView)
        } else {
            
            backgroundView = UIView(frame: containerView.bounds)
                       backgroundView.addSubview(fadeView)
                       fadeView.alpha = 0
            
            selectedImageViewSnapshot = selectedDriverCellImageSnapshot
        }
        
        toView.alpha = 0
        
        [backgroundView, selectedImageViewSnapshot, detailViewImageSnapshot].forEach { view in
            if let view = view {
                containerView.addSubview(view)
            }
        }
        
        containerView.addSubview(selectedImageViewSnapshot ?? UIView())
        
        let detailViewImageViewRect = toVC.driverImageWrapperView.convert(toVC.driverImageWrapperView.frame, to: toVC.driverImageWrapperView.window)
        
        selectedDriverCellImageSnapshot.frame = self.cellImageViewRect
        detailViewImageSnapshot.frame = detailViewImageViewRect
        
        detailViewImageSnapshot.alpha = isDismissed ? 1 : 0
        selectedDriverCellImageSnapshot.alpha = isDismissed ? 0 : 1
        
        
        let finalFrame = transitionContext.finalFrame(for: toVC)
        toView.frame = fromVC.view.frame
        containerView.addSubview(toView)
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: duration, delay: 0.0, options: [.curveEaseOut, .layoutSubviews], animations: {
//            if let selectedCell = selectedDriverCell {
//                selectedCell.frame = toVC.driverImageView.frame
//            }
            selectedDriverCellImageSnapshot.frame = self.isDismissed ? self.cellImageViewRect : detailViewImageViewRect
            detailViewImageSnapshot.frame = self.isDismissed ? self.cellImageViewRect : detailViewImageViewRect
            fadeView.alpha = self.isDismissed ? 0 : 1
            
        }, completion: { position in
//            fromVC.view.isHidden = false
//            containerView.addSubview(toVC.view)
            backgroundView.removeFromSuperview()
            selectedDriverCellImageSnapshot.removeFromSuperview()
            detailViewImageSnapshot.removeFromSuperview()
            toView.layoutIfNeeded()
            toView.alpha = 1
            
            transitionContext
                .completeTransition(!transitionContext.transitionWasCancelled)
            
        })
    }
    
    private func copyVisibleCells(visibleCells: [UICollectionViewCell], currSelected: DriverThumbnailCollectionViewCell?) -> (cells: [DriverThumbnailCollectionViewCell], selectedCell: DriverThumbnailCollectionViewCell?) {
        var cells = [DriverThumbnailCollectionViewCell]()
        var selectedCell: DriverThumbnailCollectionViewCell?
        
        guard let visibleCells = visibleCells as? [DriverThumbnailCollectionViewCell] else {
            return (cells, selectedCell)
        }
        
        visibleCells.forEach { cell in
            let copyCell = cell.copy() as! DriverThumbnailCollectionViewCell
            cells.append(copyCell)
            
            if cell == currSelected {
                selectedCell = copyCell
            }
        }
        return (cells, selectedCell)
    }
}
