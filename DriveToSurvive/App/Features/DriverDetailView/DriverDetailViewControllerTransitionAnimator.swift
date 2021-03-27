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
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isDismissed {
            dismiss(transitionContext: transitionContext)
        } else {
            present(transitionContext: transitionContext)
        }
    }
    
    private func dismiss(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? DriverDetailViewController else { return }
        guard let toVC = transitionContext.viewController(forKey: .to) as? HomeViewController else { return }
        guard let selectedCell = toVC.selectedDriverCell else { return }
        
        let containerView = transitionContext.containerView
        let animationDuration = transitionDuration(using: transitionContext)
        
        guard let fromView = fromVC.view else {
            transitionContext.completeTransition(false)
            return
        }
        
        guard let selectedDriverCellImageSnapshot = toVC.selectedDriverCell?.thumbnailImageView.snapshotView(afterScreenUpdates: true),
              let detailViewImageSnapshot = fromVC.driverImageWrapperView.snapshotView(afterScreenUpdates: true),
              let closeButtonSnapshot = fromVC.closeButton.snapshotView(afterScreenUpdates: true),
              let driverNameLabelSnapshot = fromVC.driverNameLabel.snapshotView(afterScreenUpdates: true),
              let teamNameLabelSnapshot = fromVC.teamNameLabel.snapshotView(afterScreenUpdates: true),
              let descriptionLabelSnapshot = fromVC.descriptionLabel.snapshotView(afterScreenUpdates: true),
              let readMoreButtonSnapshot = fromVC.readMoreButton.snapshotView(afterScreenUpdates: true),
              let shareButtonSnapshot = fromVC.shareButton.snapshotView(afterScreenUpdates: true)
              else {
            transitionContext.completeTransition(true)
            return
        }
        
        self.cellImageViewRect = getRektWithTranslatedCoordinates(for: selectedCell.thumbnailImageView)
        
        let cellImageWrapperViewRect = CGRect(x: 0, y: 0, width: fromView.frame.width, height: fromView.frame.height)
        self.cellImageWrapperView = UIView(frame: cellImageWrapperViewRect)
        cellImageWrapperView!.backgroundColor = .white
        containerView.addSubview(cellImageWrapperView!)
        
        fromView.alpha = 0
        
        [selectedDriverCellImageSnapshot, detailViewImageSnapshot].forEach { view in
            containerView.addSubview(view)
        }
        
        /* translate coordinates of detail view controller subview snapshots. */
        
        let closeButtonRect = fromVC.closeButton.frame
        let detailViewImageViewRect = fromVC.driverImageWrapperView.frame
        let driverNameLabelRect = fromVC.driverNameLabel.frame
        let teamNameLabelRect = fromVC.teamNameLabel.frame
        let descriptionLabelRect = fromVC.descriptionLabel.frame
        let readMoreButtonRect = fromVC.readMoreButton.frame
        let shareButtonRect = fromVC.shareButton.frame
        
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
        
        [closeButtonSnapshot, detailViewImageSnapshot, driverNameLabelSnapshot, teamNameLabelSnapshot, descriptionLabelSnapshot, readMoreButtonSnapshot, shareButtonSnapshot].forEach { view in
            containerView.addSubview(view)
            
        }
        
        /* end of setting snapshot frames */
        
        /* set snapshot visibility */
        closeButtonSnapshot.alpha = 1
        detailViewImageSnapshot.alpha = 1
        driverNameLabelSnapshot.alpha = 1
        teamNameLabelSnapshot.alpha = 1
        descriptionLabelSnapshot.alpha = 1
        readMoreButtonSnapshot.alpha = 1
        shareButtonSnapshot.alpha = 1
        
        selectedDriverCellImageSnapshot.alpha = 0
        
        /* end of setting snapshot visibility */
        
        /* set final frames for presented view controller subviews. */

        let closeButtonSnapshotFinalFrame = CGRect(origin: CGPoint(x: fromVC.closeButton.frame.origin.x + 100, y: fromVC.closeButton.frame.origin.y), size: fromVC.closeButton.frame.size)
        
        let driverNameLabelSnapshotFinalFrame = CGRect(origin: CGPoint(x: fromVC.driverNameLabel.frame.origin.x, y: fromVC.driverNameLabel.frame.origin.y + 300), size: fromVC.driverNameLabel.frame.size)
        
        let teamNameLabelSnapshotFinalFrame = CGRect(origin: CGPoint(x: fromVC.teamNameLabel.frame.origin.x, y: fromVC.teamNameLabel.frame.origin.y + 300), size: fromVC.teamNameLabel.frame.size)
        
        let descriptionLabelSnapshotFinalFrame = CGRect(origin: CGPoint(x: fromVC.descriptionLabel.frame.origin.x, y: fromVC.descriptionLabel.frame.origin.y + 300), size: fromVC.descriptionLabel.frame.size)
        
        let readMoreButtonSnapshotFinalFrame = CGRect(origin: CGPoint(x: fromVC.readMoreButton.frame.origin.x, y: fromVC.readMoreButton.frame.origin.y + 300), size: fromVC.readMoreButton.frame.size)
        
        let shareButtonSnapshotFinalFrame = CGRect(origin: CGPoint(x: fromVC.shareButton.frame.origin.x, y: fromVC.shareButton.frame.origin.y + 300), size: fromVC.shareButton.frame.size)
        
        /* end of setting final frames for presented view controller subviews. */
        
        
        fromVC.view.frame = transitionContext.finalFrame(for: fromVC)
        containerView.addSubview(fromVC.view)
        
        let animation = UIViewPropertyAnimator(duration: animationDuration, curve: .easeInOut)
        animation.addAnimations {
          UIView.animateKeyframes(withDuration: animationDuration, delay: 0, animations: {
            
            self.cellImageWrapperView?.frame = CGRect(x: 0, y: fromView.frame.height, width: fromView.frame.width, height: 0)
            detailViewImageSnapshot.frame = selectedDriverCellImageSnapshot.frame
            
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.9, animations: {
               
            })
            
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                readMoreButtonSnapshot.alpha = 0
                readMoreButtonSnapshot.frame = readMoreButtonSnapshotFinalFrame
                shareButtonSnapshot.alpha = 0
                shareButtonSnapshot.frame = shareButtonSnapshotFinalFrame
                closeButtonSnapshot.alpha = 0
                driverNameLabelSnapshot.alpha = 0
                teamNameLabelSnapshot.alpha = 0
                descriptionLabelSnapshot.alpha = 0
                closeButtonSnapshot.frame = closeButtonSnapshotFinalFrame
                driverNameLabelSnapshot.frame = driverNameLabelSnapshotFinalFrame
                teamNameLabelSnapshot.frame = teamNameLabelSnapshotFinalFrame
                descriptionLabelSnapshot.frame = descriptionLabelSnapshotFinalFrame
                
            }
            
          }, completion: { completed in

            fromView.alpha = 0
            self.cellImageWrapperView?.removeFromSuperview()
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
              let detailViewImageSnapshot = toVC.driverImageWrapperView.snapshotView(afterScreenUpdates: true),
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

        let cellImageWrapperViewRect = CGRect(x: 0, y: toView.frame.height, width: toView.frame.width, height: 0)
        
        self.cellImageWrapperView = UIView(frame: cellImageWrapperViewRect)
        cellImageWrapperView!.backgroundColor = .white
        containerView.addSubview(cellImageWrapperView!)
        
        /* end of animate white background behind cell image snapshot */
        
        backgroundView = UIView(frame: containerView.bounds)
                   backgroundView.addSubview(fadeView)
                   fadeView.alpha = 0
        
        selectedImageViewSnapshot = selectedDriverCellImageSnapshot
        
        toView.alpha = 0
        
        [selectedImageViewSnapshot, detailViewImageSnapshot].forEach { view in
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
        readMoreButtonSnapshot.frame.origin.y = readMoreButtonSnapshot.frame.origin.y + 300
        shareButtonSnapshot.frame.origin.y = shareButtonSnapshot.frame.origin.y + 300
        
       // print("\(toVC.driverNameLabel.text!) rect: \(driverNameLabelSnapshot.frame)")
        
        containerView.addSubview(closeButtonSnapshot)
        containerView.addSubview(driverNameLabelSnapshot)
        containerView.addSubview(teamNameLabelSnapshot)
        containerView.addSubview(descriptionLabelSnapshot)
        containerView.addSubview(readMoreButtonSnapshot)
        containerView.addSubview(shareButtonSnapshot)
        
        
        /* end of setting initial frames for presented view controller subviews. */
        
        //toVC.view.backgroundColor = .white
        
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
