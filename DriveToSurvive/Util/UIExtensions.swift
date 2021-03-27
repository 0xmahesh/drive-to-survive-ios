//
//  UIExtensions.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 3/21/21.
//

import UIKit
import Lottie

extension UIView {
    
    func fadeBorders(shadowColor: UIColor = .white) {
        let maskLayer = CAGradientLayer()
        maskLayer.frame = self.bounds
        maskLayer.shadowRadius = 5
        maskLayer.shadowPath = CGPath(roundedRect: self.bounds.insetBy(dx: 5, dy: 5), cornerWidth: 10, cornerHeight: 10, transform: nil)
        maskLayer.shadowOpacity = 1
        maskLayer.shadowOffset = CGSize.zero
        maskLayer.shadowColor = shadowColor.cgColor
        self.layer.mask = maskLayer
    }
    
    func dropShadow(color: UIColor, shadowOffset: CGSize = .zero, shadowradius: CGFloat = 10, shadowOpacity: Float = 0.5) {
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = shadowradius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
    
    func makeRoundedCorner(radius: CGFloat) {
        self.layer.cornerRadius = radius
        layoutIfNeeded()
    }
    
    func flash(numberOfFlashes: Float) {
       let flash = CABasicAnimation(keyPath: "opacity")
       flash.duration = 0.5
       flash.fromValue = 1
       flash.toValue = 0.75
       flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
       flash.autoreverses = true
       flash.repeatCount = numberOfFlashes
       layer.add(flash, forKey: nil)
   }
}


extension UILabel {
    func heightForView() -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x:0, y:0, width:self.frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = self.font
        label.text = self.text

        label.sizeToFit()
        return label.frame.height
    }
}

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UIViewController {
  func presentInFullScreen(_ viewController: UIViewController,
                           animated: Bool,
                           completion: (() -> Void)? = nil) {
    viewController.modalPresentationStyle = .overFullScreen
    present(viewController, animated: animated, completion: completion)
  }
}

//func scaleUIImageToSize(image: UIImage,  size: CGSize) -> UIImage {
//    let hasAlpha = false
//    let scale: CGFloat = 0.0
//
//    UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
//    image.draw(in: CGRect(origin: .zero, size: size))
//
//    let scaledImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
//    UIGraphicsEndImageContext()
//
//    return scaledImage
//}

extension UIDevice {
    /// Returns `true` if the device has a notch
    var hasNotch: Bool {
        guard #available(iOS 11.0, *), let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return false }
        if UIDevice.current.orientation.isPortrait {
            return window.safeAreaInsets.top >= 44
        } else {
            return window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0
        }
    }
}

public extension UIView {
    func fillSuperview() {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = superview.translatesAutoresizingMaskIntoConstraints
        if translatesAutoresizingMaskIntoConstraints {
            autoresizingMask = [.flexibleWidth, .flexibleHeight]
            frame = superview.bounds
        } else {
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
            leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
        }
    }
}
