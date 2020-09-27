//
//  ActionSheetViewController.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 27/09/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import UIKit

class ActionSheetViewController: UIViewController {
    lazy var actionSheetTransitioningDelegate = ActionSheetTransitioningDelegate()
    
    var contentSize: CGSize {
        fatalError("Child view controller should everride 'contentSize'")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        modalPresentationStyle = .custom
        transitioningDelegate = actionSheetTransitioningDelegate
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        modalPresentationStyle = .custom
        transitioningDelegate = actionSheetTransitioningDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preferredContentSize = contentSize
    }
}
