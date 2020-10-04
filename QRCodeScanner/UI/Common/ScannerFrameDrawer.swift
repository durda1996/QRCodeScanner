//
//  ScannerFrameDrawer.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 04/10/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import UIKit

enum ScannerFrameCorner: CaseIterable {
    case leftTop
    case rightTop
    case leftBottom
    case rightBottom
}

struct ScannerFrameDrawer {
    private let cornerWidth: CGFloat = 35.0
    private let lineWidth: CGFloat = 7.0
    
    func draw(on view: UIView) {
        ScannerFrameCorner.allCases.forEach { draw(on: view, corner: $0) }
    }
}

private extension ScannerFrameDrawer {
    func draw(on view: UIView, corner: ScannerFrameCorner) {
        let size = view.frame.size
        let firstPoint = point1(forSize: size, corner: corner)
        let secondPoint = point2(forSize: size, corner: corner)
        let thirdPoint = point3(forSize: size, corner: corner)
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: firstPoint)
        bezierPath.addLine(to: secondPoint)
        bezierPath.addLine(to: thirdPoint)
        bezierPath.addLine(to: secondPoint)
        
        let layer = CAShapeLayer()
        layer.lineWidth = 7
        layer.path = bezierPath.cgPath
        layer.strokeColor = UIColor.darkGray.cgColor
        
        view.layer.addSublayer(layer)
    }
    
    func point1(forSize size: CGSize, corner: ScannerFrameCorner) -> CGPoint {
        switch corner {
        case .leftTop:
            return CGPoint(x: 0, y: cornerWidth)
        case .rightTop:
            return CGPoint(x: size.width - cornerWidth, y: 0)
        case .leftBottom:
            return CGPoint(x: cornerWidth, y: size.height)
        case .rightBottom:
            return CGPoint(x: size.width, y: size.height - cornerWidth)
        }
    }
    
    func point2(forSize size: CGSize, corner: ScannerFrameCorner) -> CGPoint {
        switch corner {
        case .leftTop:
            return CGPoint(x: 0, y: 0)
        case .rightTop:
            return CGPoint(x: size.width, y: 0)
        case .leftBottom:
            return CGPoint(x: 0, y: size.height)
        case .rightBottom:
            return CGPoint(x: size.width, y: size.height)
        }
    }
    
    func point3(forSize size: CGSize, corner: ScannerFrameCorner) -> CGPoint {
        switch corner {
        case .leftTop:
            return CGPoint(x: cornerWidth, y: 0)
        case .rightTop:
            return CGPoint(x: size.width, y: cornerWidth)
        case .leftBottom:
            return CGPoint(x: 0, y: size.height - cornerWidth)
        case .rightBottom:
            return CGPoint(x: size.width - cornerWidth, y: size.height)
        }
    }
}
