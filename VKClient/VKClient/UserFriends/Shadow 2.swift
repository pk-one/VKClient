//
//  Shadow.swift
//  VKClient
//
//  Created by Pavel Olegovich on 27.07.2021.
//

import UIKit

//@IBDesignable
class Shadow: UIView {

    @IBInspectable var shadowColor: UIColor = .black {
        didSet{
            self.updateColors()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 7 {
        didSet {
            self.updateOpacity()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 7 {
        didSet{
            self.updateRadius()
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet{
            self.updateOffset()
        }
    }
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    var shadowLayer: CAShapeLayer {
        return self.layer as! CAShapeLayer
    }
    
    private func updateColors() {
        self.shadowLayer.shadowColor = self.shadowColor.cgColor
    }
    
    private func updateOpacity() {
        self.shadowLayer.shadowOpacity = self.shadowOpacity
    }
    
    private func updateRadius() {
        self.shadowLayer.shadowRadius = self.shadowRadius
    }
    
    private func updateOffset() {
        self.shadowLayer.shadowOffset = self.shadowOffset
    }
}
