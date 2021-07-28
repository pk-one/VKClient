//
//  Shadow.swift
//  VKClient
//
//  Created by Pavel Olegovich on 27.07.2021.
//

import UIKit

//@IBDesignable
class Shadow: UIView {

    @IBInspectable var Color: UIColor = .black {
        didSet{
            self.updateColors()
        }
    }
    
    @IBInspectable var Opacity: Float = 7 {
        didSet {
            self.updateOpacity()
        }
    }
    
    @IBInspectable var Radius: CGFloat = 7 {
        didSet{
            self.updateRadius()
        }
    }
    
    @IBInspectable var Offset: CGSize = .zero {
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
    
    var masksToBounds: Bool = false
    
    func updateColors() {
        self.shadowLayer.shadowColor = self.Color.cgColor
    }
    
    func updateOpacity() {
        self.shadowLayer.shadowOpacity = self.Opacity
    }
    
    func updateRadius() {
        self.shadowLayer.shadowRadius = self.Radius
    }
    
    func updateOffset() {
        self.shadowLayer.shadowOffset = self.Offset
    }
}
