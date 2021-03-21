//
//  CustomViewControllerTransition.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 3/9/21.
//

import UIKit

class CustomViewControllerTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    private var isDismissed: Bool = false
    
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
    
    private func copyVisibleCells(visibleCells: [UICollectionViewCell], currSelected: ParallaxCollectionViewCell?) -> (cells: [ParallaxCollectionViewCell], selectedCell: ParallaxCollectionViewCell?) {
        var cells = [ParallaxCollectionViewCell]()
        var selectedCell: ParallaxCollectionViewCell?
        
        guard let visibleCells = visibleCells as? [ParallaxCollectionViewCell] else {
            return (cells, selectedCell)
        }
        
        visibleCells.forEach { cell in
            let copyCell = cell.copy() as! ParallaxCollectionViewCell
            cells.append(copyCell)
            
            if cell == currSelected {
                selectedCell = copyCell
            }
        }
        return (cells, selectedCell)
    }
    
    func present(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? HomeViewController else { return }
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        //containerView.backgroundColor = .white
        
        let finalFrame = transitionContext.finalFrame(for: toVC)
        toVC.view.frame = finalFrame
        
        let clonedCells =  copyVisibleCells(visibleCells: fromVC.newsCollectionView.visibleCells, currSelected: fromVC.selectedNewsItemCell)
        
        for cell in clonedCells.cells {
            let convertedFrame = fromVC.newsCollectionView.convert(cell.frame, to: nil)
            cell.frame = convertedFrame
            containerView.addSubview(cell)
        }
        
        var selectedCellOriginalFrame: CGRect = .zero
        if let selectedCell = clonedCells.selectedCell {
            selectedCellOriginalFrame = selectedCell.frame
        }
        
        fromVC.view.isHidden = true
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: duration, delay: 0.0, options: [.curveEaseOut, .layoutSubviews], animations: {
            // set template to full screen.
            if let selectedCell =  clonedCells.selectedCell {
                selectedCell.isFullScreen = true
                selectedCell.frame = finalFrame
            }
            
            //slide over other cells.
            
            for cell in clonedCells.cells {
                if cell != clonedCells.selectedCell {
                    var translateX: CGFloat = 0
                    if cell.frame.minX < selectedCellOriginalFrame.minX {
                        translateX = -(cell.frame.maxX + 20.0)
                    } else {
                        translateX = finalFrame.width - (cell.frame.minX - 20.0)
                    }
                    
                    cell.transform =  CGAffineTransform(translationX: translateX, y: 0)
                }
            }
        }, completion: { position in
            clonedCells.cells.forEach { cell in
                cell.removeFromSuperview()
            }
            fromVC.view.isHidden = false
            containerView.addSubview(toVC.view)
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    
    func dismiss(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) else { return }
        guard let toVC = transitionContext.viewController(forKey: .to) as? HomeViewController else {
            return
        }
        
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toVC)
        toVC.view.frame = finalFrame
        
        let clonedCells = copyVisibleCells(visibleCells: toVC.newsCollectionView.visibleCells, currSelected: toVC.selectedNewsItemCell)
        
        var selectedCellOriginalFrame: CGRect = .zero
        
        //set selected cell to full screen.
        if let selectedCell = clonedCells.selectedCell {
            selectedCellOriginalFrame = toVC.newsCollectionView.convert(selectedCell.frame, to: nil)
            
            selectedCell.isFullScreen = true
            selectedCell.frame = fromVC.view.frame
        }
        
        for cell in clonedCells.cells {
            //slide off other cells from screen.
            if cell != clonedCells.selectedCell {
                let globalFrame = toVC.newsCollectionView.convert(cell.frame, to: nil)
                cell.frame = globalFrame
            
            var translateX: CGFloat = 0
            if cell.frame.minX < selectedCellOriginalFrame.minX {
                translateX = -(cell.frame.maxX + 20.0)
            } else {
                translateX = finalFrame.width - (cell.frame.minX - 20.0)
            }
            cell.transform = CGAffineTransform(translationX: translateX, y: 0)
            }
            containerView.addSubview(cell)
        }
        
        fromVC.view.removeFromSuperview()
        toVC.view.isHidden = false
        
        //layout selected cell in full screen mode.
        clonedCells.selectedCell?.layoutSubviews()
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: duration, delay: 0.0, options: [.curveEaseOut, .layoutSubviews], animations: {
            if let selectedCell = clonedCells.selectedCell {
                selectedCell.isFullScreen = false
                selectedCell.frame = selectedCellOriginalFrame
            }
            
            for cell in clonedCells.cells {
                if cell != clonedCells.selectedCell {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
                }
            }
        }, completion: { position in
            clonedCells.cells.forEach { cell in
                cell.removeFromSuperview()
            }
            toVC.view.isHidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
}
