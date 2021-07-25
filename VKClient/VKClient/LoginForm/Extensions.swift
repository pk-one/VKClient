//
//  Extensions.swift
//  VKClient
//
//  Created by Pavel Olegovich on 16.07.2021.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

public extension UIColor {
    static let varna = UIColor.rgb(40.0, 35.0, 80.0)
}

public extension UIColor {
    static func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
        return UIColor.rgba(r, g, b, 1.0)
    }
    static func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
}

extension UIColor {
    static let brandGrey = UIColor(red: 227.0 / 255.0, green: 229.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
    static let newsfeedBlue = UIColor(red: 102.0 / 255.0, green: 159.0 / 255.0, blue: 212.0 / 255.0, alpha: 1.0)
    static let newsfeedPaleRed = UIColor(red: 210.0 / 255.0, green: 79.0 / 255.0, blue: 84.0 / 255.0, alpha: 1.0)
    static let newsfeedDarkGrey = UIColor(red: 58.0 / 255.0, green: 59.0 / 255.0, blue: 60.0 / 255.0, alpha: 1.0)
    static let newsfeedPaleGrey = UIColor(red: 147.0 / 255.0, green: 158.0 / 255.0, blue: 169.0 / 255.0, alpha: 1.0)
    static let footerGrey = UIColor(red: 161.0 / 255.0, green: 165.0 / 255.0, blue: 169.0 / 255.0, alpha: 1.0)
}

extension UIView {
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,
                              width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
}

extension FriendsPhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameVC = collectionView.frame
        let widthCell = frameVC.width / 2
        let heightCell = widthCell
        let spacing = CGFloat((countCells + 1)) * offSet / CGFloat(countCells)
        return CGSize(width: widthCell - spacing, height: heightCell - (offSet * 2))
    }
}
