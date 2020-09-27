//
//  ActionSheetPresentationController.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 26/09/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import UIKit


class ActionSheetTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        presented.view.layer.cornerRadius = 10.0
        return ActionSheetPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

class ActionSheetPresentationController: UIPresentationController {
    private lazy var dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.alpha = 0.0
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss)))
        return view
    }()
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else {
            return .zero
        }
        
        let preferredHeight = presentedViewController.preferredContentSize.height
        
        return .init(x: 0,
                     y: containerView.frame.height - preferredHeight,
                     width: containerView.bounds.width,
                     height: preferredHeight)
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else {
            return
        }
        
        containerView.insertSubview(dimmingView, at: 0)
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        dimmingView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        
        guard let transitionCoordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return 
        }
        
        transitionCoordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
        })
    }
    
    override func dismissalTransitionWillBegin() {
        guard let transitionCoordinator = presentedViewController.transitionCoordinator else {
           dimmingView.alpha = 0.0
           return
         }

         transitionCoordinator.animate(alongsideTransition: { _ in
           self.dimmingView.alpha = 0.0
         })
    }
    
    @objc private func dismiss() {
        presentedViewController.dismiss(animated: true)
    }
}
