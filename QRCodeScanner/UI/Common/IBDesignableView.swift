//
//  IBDesignableView.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 04/10/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import UIKit

protocol NibLoadingProtocol {
    var nibName: String { get }
    func setupView()
    func loadViewFromNib() -> UIView?
}

@IBDesignable
class IBDesignableView: UIView {
    var contentView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
}

extension IBDesignableView: NibLoadingProtocol {
    var nibName: String {
        String(describing: type(of: self))
    }
    
    func setupView() {
        guard let view = loadViewFromNib() else {
            print("Cannot load view for %@ from nib", nibName)
            return
        }
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let nibObjects = nib.instantiate(withOwner: self, options: nil)
        
        return nibObjects.first as? UIView
    }
}
