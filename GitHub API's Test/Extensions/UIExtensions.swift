//
//  UIExtensions.swift
//  GitHub API's Test
//
//  Created by Lucas Brandão Pereira on 03/11/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//

import Foundation

import UIKit

@IBDesignable
class RoundedView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 2.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    fileprivate var shadowLayer: CAShapeLayer!
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.shadowPath = shadowLayer.path
        }
    }
}
