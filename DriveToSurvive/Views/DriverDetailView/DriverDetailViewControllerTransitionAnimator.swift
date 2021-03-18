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
    
    private var cellImageWrapperView: UIView?
    
    init(isDismissed: Bool) {
        self.isDismissed = isDismissed
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
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
        fadeView.backgroundColor = .white
        
        guard let selectedDriverCellImageSnapshot = fromVC.selectedDriverCell?.thumbnailImageView.snapshotView(afterScreenUpdates: true),
              let detailViewImageSnapshot = toVC.driverImageView.snapshotView(afterScreenUpdates: true),
              let closeButtonSnapshot = toVC.closeButton.snapshotView(afterScreenUpdates: true),
              let driverNameLabelSnapshot = toVC.driverNameLabel.snapshotView(afterScreenUpdates: true),
              let teamNameLabelSnapshot = toVC.teamNameLabel.snapshotView(afterScreenUpdates: true),
              let descriptionLabelSnapshot = toVC.descriptionLabel.snapshotView(afterScreenUpdates: true),
              let readMoreButtonSnapshot = toVC.readMoreButton.snapshotView(afterScreenUpdates: true),
              let shareButtonSnapshot = toVC.shareButton.snapshotView(afterScreenUpdates: true)
              else {
            transitionContext.completeTransition(true)
            return
        }
        
        let animationDuration = transitionDuration(using: transitionContext)
        
        self.cellImageViewRect = selectedCell.thumbnailImageView.convert(selectedCell.thumbnailImageView.bounds, to: window)
        
        
        /* animate white background behind cell snapshot */
        var cellImageWrapperViewOriginX: CGFloat = 0
        if self.cellImageViewRect.minX <= toView.frame.width/3 {
            cellImageWrapperViewOriginX = 0
        } else if self.cellImageViewRect.minX <= toView.frame.width/2 {
            cellImageWrapperViewOriginX = toView.center.x - (0.5 * (self.cellImageViewRect.width * 1.1))
        } else {
            cellImageWrapperViewOriginX = toView.frame.width - self.cellImageViewRect.width * 1.1
        }
        
        let cellImageWrapperViewRect = CGRect(origin: CGPoint(x: cellImageWrapperViewOriginX, y: toView.frame.height), size: CGSize(width: self.cellImageViewRect.width * 1.1, height: self.cellImageViewRect.height * 1.1))
        
        self.cellImageWrapperView = UIView(frame: cellImageWrapperViewRect)
        cellImageWrapperView!.backgroundColor = .white
        containerView.addSubview(cellImageWrapperView!)
        
        /* end of animate white background behind cell image snapshot */
        
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
        
        /* translate coordinates of detail view controller subview snapshots. */
        
        let closeButtonRect = getRektWithTranslatedCoordinates(for: toVC.closeButton)
        let detailViewImageViewRect = getRektWithTranslatedCoordinates(for: toVC.driverImageWrapperView)
        let driverNameLabelRect = getRektWithTranslatedCoordinates(for: toVC.driverNameLabel)
        let teamNameLabelRect = getRektWithTranslatedCoordinates(for: toVC.teamNameLabel)
        let descriptionLabelRect = getRektWithTranslatedCoordinates(for: toVC.descriptionLabel)
        let readMoreButtonRect = getRektWithTranslatedCoordinates(for: toVC.readMoreButton)
        let shareButtonRect = getRektWithTranslatedCoordinates(for: toVC.shareButton)
        
        /* end of coordinate translation */
        
        /* set snapshot frames. */
        
        selectedDriverCellImageSnapshot.frame = self.cellImageViewRect
        
        
        closeButtonSnapshot.frame = closeButtonRect
        detailViewImageSnapshot.frame = detailViewImageViewRect
        driverNameLabelSnapshot.frame = driverNameLabelRect
        teamNameLabelSnapshot.frame = teamNameLabelRect
        descriptionLabelSnapshot.frame = descriptionLabelRect
        readMoreButtonSnapshot.frame = readMoreButtonRect
        shareButtonSnapshot.frame = shareButtonRect
        
        /* end of setting snapshot frames */
        
        /* set snapshot visibility */
        closeButtonSnapshot.alpha = isDismissed ? 1 : 0
        detailViewImageSnapshot.alpha = isDismissed ? 1 : 0
        driverNameLabelSnapshot.alpha = isDismissed ? 1 : 0
        teamNameLabelSnapshot.alpha = isDismissed ? 1 : 0
        descriptionLabelSnapshot.alpha = isDismissed ? 1 : 0
        readMoreButtonSnapshot.alpha = isDismissed ? 1 : 0
        shareButtonSnapshot.alpha = isDismissed ? 1 : 0
        
        selectedDriverCellImageSnapshot.alpha = isDismissed ? 0 : 1
        
        /* end of setting snapshot visibility */
        
        /* set initial frames for presented view controller subviews. */
        
        closeButtonSnapshot.frame.origin.x = toView.frame.size.width + 100
        driverNameLabelSnapshot.frame.origin.y = driverNameLabelSnapshot.frame.origin.y + 300
        teamNameLabelSnapshot.frame.origin.y = teamNameLabelSnapshot.frame.origin.y + 300
        descriptionLabelSnapshot.frame.origin.y = descriptionLabelSnapshot.frame.origin.y + 300
        readMoreButtonSnapshot.frame.origin.y = readMoreButtonSnapshot.frame.origin.y + 200
        shareButtonSnapshot.frame.origin.y = shareButtonSnapshot.frame.origin.y + 300
        
        print("\(toVC.driverNameLabel.text!) rect: \(driverNameLabelSnapshot.frame)")
        
        containerView.addSubview(closeButtonSnapshot)
        containerView.addSubview(driverNameLabelSnapshot)
        containerView.addSubview(teamNameLabelSnapshot)
        containerView.addSubview(descriptionLabelSnapshot)
        containerView.addSubview(readMoreButtonSnapshot)
        containerView.addSubview(shareButtonSnapshot)
        
        
        /* end of setting initial frames for presented view controller subviews. */
        
        toVC.view.backgroundColor = .white
        
        let finalFrame = transitionContext.finalFrame(for: toVC)
        toVC.view.frame = finalFrame
        containerView.addSubview(toVC.view)
        
        let animation = UIViewPropertyAnimator(duration: animationDuration, curve: .easeInOut)
        animation.addAnimations {
          UIView.animateKeyframes(withDuration: animationDuration, delay: 0, animations: {
            
            self.cellImageWrapperView?.frame = finalFrame
            fadeView.alpha = 1
            
            readMoreButtonSnapshot.alpha = 1
            readMoreButtonSnapshot.frame = readMoreButtonRect
            shareButtonSnapshot.alpha = 1
            shareButtonSnapshot.frame = shareButtonRect
            
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 1) {
                closeButtonSnapshot.alpha = 1
                closeButtonSnapshot.frame = closeButtonRect
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 1) {
                driverNameLabelSnapshot.alpha = 1
                teamNameLabelSnapshot.alpha = 1
                driverNameLabelSnapshot.frame = driverNameLabelRect
                teamNameLabelSnapshot.frame = teamNameLabelRect
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.28, relativeDuration: 1) {
                descriptionLabelSnapshot.alpha = 1
                descriptionLabelSnapshot.frame = descriptionLabelRect
            }

            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.75) {
                selectedDriverCellImageSnapshot.frame = detailViewImageViewRect
                detailViewImageSnapshot.frame = detailViewImageViewRect
//                selectedDriverCellImageSnapshot.alpha = 0
//                detailViewImageSnapshot.alpha = 1
            }
            
          }, completion: { completed in
            toVC.view.addSubview(detailViewImageSnapshot)
            
            
            toVC.view.alpha = 1
            self.cellImageWrapperView?.removeFromSuperview()
            backgroundView.removeFromSuperview()
            selectedDriverCellImageSnapshot.removeFromSuperview()
            detailViewImageSnapshot.removeFromSuperview()
            
            driverNameLabelSnapshot.removeFromSuperview()
            closeButtonSnapshot.removeFromSuperview()
            teamNameLabelSnapshot.removeFromSuperview()
            descriptionLabelSnapshot.removeFromSuperview()
            readMoreButtonSnapshot.removeFromSuperview()
            shareButtonSnapshot.removeFromSuperview()
            
            transitionContext
                .completeTransition(!transitionContext.transitionWasCancelled)
          })
        }
        animation.startAnimation()
        
    }
    
   
  
    
    private func getRektWithTranslatedCoordinates(for view: UIView) -> CGRect{
        return view.convert(view.frame, to: view.window)
    }
}
