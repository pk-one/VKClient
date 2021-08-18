//
//  FullPhotoAnimator.swift
//  VKClient
//
//  Created by Pavel Olegovich on 16.08.2021.
//

import UIKit

class FullPhotoAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let presentationStartCell: UICollectionViewCell!
    let isPresenting: Bool
    
    init(presentationStartCell: UICollectionViewCell, isPresenting: Bool ) {
        self.presentationStartCell = presentationStartCell
        self.isPresenting = isPresenting
    }
    //проверка показать или спрятать
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            present(using: transitionContext)
        } else {
            dismiss(using: transitionContext)
        }
    }
    
    private func present(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let presentedViewController = transitionContext.viewController(forKey: .to),
              let presentedView = transitionContext.view(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        
        let finalFrame = transitionContext.finalFrame(for: presentedViewController)
        let startCellFrame = presentationStartCell.convert(presentationStartCell.bounds, to: containerView)
        let startCellCenter = CGPoint(x: startCellFrame.midX, y: startCellFrame.midY)
    
        containerView.addSubview(presentedView)
        
        presentedView.center = startCellCenter
        presentedView.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        presentedView.backgroundColor = .clear
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       animations: {
                        presentedView.transform = CGAffineTransform(scaleX: 1, y: 1)
                        presentedView.frame = finalFrame
                        presentedView.backgroundColor = .systemBackground
                       }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
    
    private func dismiss(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        guard let dismissedView = transitionContext.view(forKey: .from),
              let presentedView = transitionContext.view(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        containerView.insertSubview(presentedView, belowSubview: dismissedView)
        let startCellFrame = presentationStartCell.convert(presentationStartCell.bounds, to: containerView)
        let startCellCenter = CGPoint(x: startCellFrame.midX, y: startCellFrame.midY)
        dismissedView.backgroundColor = .clear
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       animations: {
                        dismissedView.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
                        dismissedView.center = startCellCenter
                        
                       }) { finished in
                    transitionContext.completeTransition(finished)
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
}
