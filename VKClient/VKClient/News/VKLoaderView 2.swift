//
//  VKLoaderView.swift
//  VKClient
//
//  Created by Pavel Olegovich on 14.08.2021.
//

import UIKit

class VKLoaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        animationLoader()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        animationLoader()
    }
    
    private func animationLoader() {
        let layerAnimation = CAShapeLayer()
        layerAnimation.path = vkLogoPath.cgPath
        layerAnimation.strokeColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        layerAnimation.fillColor = UIColor.clear.cgColor
        layerAnimation.lineWidth = 8
        layerAnimation.lineCap = .round
        
        self.layer.addSublayer(layerAnimation)
        
        let pathAnimationStart = CABasicAnimation(keyPath: "strokeStart")
        pathAnimationStart.fromValue = 1
        pathAnimationStart.toValue = 0
        pathAnimationStart.duration = 2
        
        let pathAnimationEnd = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimationEnd.fromValue = 1
        pathAnimationEnd.toValue = 0
        pathAnimationEnd.duration = 2
        pathAnimationEnd.beginTime = 2
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 4
        animationGroup.fillMode = CAMediaTimingFillMode.backwards
        animationGroup.animations = [pathAnimationEnd, pathAnimationStart]
        animationGroup.repeatCount = .infinity
        layerAnimation.add(animationGroup, forKey: nil)
    }
}

private var vkLogoPath: UIBezierPath = {
    let bezierPath = UIBezierPath()
    bezierPath.move(to: CGPoint(x: 3.82, y: 0.51))
    bezierPath.addCurve(to: CGPoint(x: 0.07, y: 8.09), controlPoint1: CGPoint(x: 1.01, y: 1.5), controlPoint2: CGPoint(x: -0.33, y: 4.21))
    bezierPath.addCurve(to: CGPoint(x: 3.99, y: 23.22), controlPoint1: CGPoint(x: 0.35, y: 10.91), controlPoint2: CGPoint(x: 2.22, y: 18.11))
    bezierPath.addCurve(to: CGPoint(x: 34.19, y: 80.46), controlPoint1: CGPoint(x: 10.01, y: 40.63), controlPoint2: CGPoint(x: 20.76, y: 61))
    bezierPath.addCurve(to: CGPoint(x: 50.69, y: 100.68), controlPoint1: CGPoint(x: 40.67, y: 89.85), controlPoint2: CGPoint(x: 44.4, y: 94.42))
    bezierPath.addCurve(to: CGPoint(x: 108.79, y: 127.46), controlPoint1: CGPoint(x: 67.97, y: 117.89), controlPoint2: CGPoint(x: 88.69, y: 127.44))
    bezierPath.addCurve(to: CGPoint(x: 122.95, y: 124.7), controlPoint1: CGPoint(x: 115.76, y: 127.46), controlPoint2: CGPoint(x: 120.79, y: 126.48))
    bezierPath.addCurve(to: CGPoint(x: 125.38, y: 107.29), controlPoint1: CGPoint(x: 125.31, y: 122.76), controlPoint2: CGPoint(x: 125.3, y: 122.77))
    bezierPath.addCurve(to: CGPoint(x: 126.05, y: 91.94), controlPoint1: CGPoint(x: 125.45, y: 94.93), controlPoint2: CGPoint(x: 125.52, y: 93.23))
    bezierPath.addCurve(to: CGPoint(x: 131.47, y: 89.36), controlPoint1: CGPoint(x: 126.88, y: 89.89), controlPoint2: CGPoint(x: 128.07, y: 89.32))
    bezierPath.addCurve(to: CGPoint(x: 141.58, y: 93.23), controlPoint1: CGPoint(x: 134.94, y: 89.39), controlPoint2: CGPoint(x: 137.06, y: 90.2))
    bezierPath.addCurve(to: CGPoint(x: 165.4, y: 115.54), controlPoint1: CGPoint(x: 148.01, y: 97.53), controlPoint2: CGPoint(x: 154.38, y: 103.5))
    bezierPath.addCurve(to: CGPoint(x: 177.34, y: 126.41), controlPoint1: CGPoint(x: 172.46, y: 123.26), controlPoint2: CGPoint(x: 174.4, y: 125.01))
    bezierPath.addLine(to: CGPoint(x: 179.21, y: 127.29))
    bezierPath.addLine(to: CGPoint(x: 194.27, y: 127.29))
    bezierPath.addLine(to: CGPoint(x: 209.34, y: 127.29))
    bezierPath.addLine(to: CGPoint(x: 210.95, y: 126.5))
    bezierPath.addCurve(to: CGPoint(x: 204.59, y: 102.53), controlPoint1: CGPoint(x: 217.07, y: 123.48), controlPoint2: CGPoint(x: 215.1, y: 116.04))
    bezierPath.addCurve(to: CGPoint(x: 185.78, y: 81.37), controlPoint1: CGPoint(x: 199.63, y: 96.15), controlPoint2: CGPoint(x: 192.07, y: 87.64))
    bezierPath.addCurve(to: CGPoint(x: 175.85, y: 66.89), controlPoint1: CGPoint(x: 177.06, y: 72.66), controlPoint2: CGPoint(x: 175.26, y: 70.04))
    bezierPath.addCurve(to: CGPoint(x: 183.59, y: 54.44), controlPoint1: CGPoint(x: 176.01, y: 66.08), controlPoint2: CGPoint(x: 178.7, y: 61.74))
    bezierPath.addCurve(to: CGPoint(x: 209.79, y: 3.81), controlPoint1: CGPoint(x: 203.37, y: 24.87), controlPoint2: CGPoint(x: 211.26, y: 9.64))
    bezierPath.addCurve(to: CGPoint(x: 206.2, y: 0.35), controlPoint1: CGPoint(x: 209.37, y: 2.13), controlPoint2: CGPoint(x: 208.06, y: 0.87))
    bezierPath.addCurve(to: CGPoint(x: 190.87, y: 0), controlPoint1: CGPoint(x: 205.43, y: 0.14), controlPoint2: CGPoint(x: 199.5, y: 0))
    bezierPath.addCurve(to: CGPoint(x: 171.58, y: 2.58), controlPoint1: CGPoint(x: 174.66, y: -0), controlPoint2: CGPoint(x: 174.29, y: 0.05))
    bezierPath.addCurve(to: CGPoint(x: 168.19, y: 8.07), controlPoint1: CGPoint(x: 170.29, y: 3.79), controlPoint2: CGPoint(x: 169.6, y: 4.91))
    bezierPath.addCurve(to: CGPoint(x: 138.42, y: 55.96), controlPoint1: CGPoint(x: 158.95, y: 28.7), controlPoint2: CGPoint(x: 147.82, y: 46.6))
    bezierPath.addCurve(to: CGPoint(x: 129.43, y: 61.7), controlPoint1: CGPoint(x: 134.11, y: 60.24), controlPoint2: CGPoint(x: 131.83, y: 61.7))
    bezierPath.addCurve(to: CGPoint(x: 125.95, y: 59.02), controlPoint1: CGPoint(x: 127.81, y: 61.7), controlPoint2: CGPoint(x: 126.76, y: 60.89))
    bezierPath.addCurve(to: CGPoint(x: 125.37, y: 31.7), controlPoint1: CGPoint(x: 125.49, y: 57.95), controlPoint2: CGPoint(x: 125.42, y: 54.49))
    bezierPath.addCurve(to: CGPoint(x: 123.79, y: 1.87), controlPoint1: CGPoint(x: 125.31, y: 4.32), controlPoint2: CGPoint(x: 125.28, y: 3.76))
    bezierPath.addCurve(to: CGPoint(x: 100.48, y: 0), controlPoint1: CGPoint(x: 122.31, y: -0.02), controlPoint2: CGPoint(x: 122.55, y: 0))
    bezierPath.addCurve(to: CGPoint(x: 78.83, y: 0.67), controlPoint1: CGPoint(x: 80.91, y: 0), controlPoint2: CGPoint(x: 80.09, y: 0.03))
    bezierPath.addCurve(to: CGPoint(x: 75.91, y: 6.6), controlPoint1: CGPoint(x: 76.48, y: 1.87), controlPoint2: CGPoint(x: 75.43, y: 4.01))
    bezierPath.addCurve(to: CGPoint(x: 78.97, y: 11.57), controlPoint1: CGPoint(x: 76.05, y: 7.31), controlPoint2: CGPoint(x: 77.25, y: 9.26))
    bezierPath.addCurve(to: CGPoint(x: 84.46, y: 23.07), controlPoint1: CGPoint(x: 82.13, y: 15.79), controlPoint2: CGPoint(x: 83.52, y: 18.71))
    bezierPath.addCurve(to: CGPoint(x: 85.08, y: 46.44), controlPoint1: CGPoint(x: 85.02, y: 25.66), controlPoint2: CGPoint(x: 85.08, y: 27.89))
    bezierPath.addCurve(to: CGPoint(x: 83.62, y: 70.51), controlPoint1: CGPoint(x: 85.08, y: 67.82), controlPoint2: CGPoint(x: 85.02, y: 68.78))
    bezierPath.addCurve(to: CGPoint(x: 78.09, y: 70.63), controlPoint1: CGPoint(x: 82.61, y: 71.76), controlPoint2: CGPoint(x: 80.28, y: 71.81))
    bezierPath.addCurve(to: CGPoint(x: 43.25, y: 12.2), controlPoint1: CGPoint(x: 68.89, y: 65.68), controlPoint2: CGPoint(x: 52.88, y: 38.84))
    bezierPath.addCurve(to: CGPoint(x: 38.3, y: 2.3), controlPoint1: CGPoint(x: 41.04, y: 6.07), controlPoint2: CGPoint(x: 39.95, y: 3.9))
    bezierPath.addCurve(to: CGPoint(x: 19.6, y: 0.01), controlPoint1: CGPoint(x: 35.94, y: 0.02), controlPoint2: CGPoint(x: 35.74, y: -0))
    bezierPath.addCurve(to: CGPoint(x: 3.82, y: 0.51), controlPoint1: CGPoint(x: 8.06, y: 0.03), controlPoint2: CGPoint(x: 4.9, y: 0.13))
    bezierPath.close()
    bezierPath.usesEvenOddFillRule = true
    return bezierPath
}()

