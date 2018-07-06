
import UIKit

extension UIView {
    
    public func round(corners: UIRectCorner, radius: CGFloat) {
        if corners == .allCorners {
            layer.cornerRadius = radius
            layer.masksToBounds = true
            
        } else {
            if mask?.frame.size != frame.size {
                let mask = CAShapeLayer()
                mask.path = UIBezierPath(roundedRect: layer.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
                layer.mask = mask
            }
        }
    }
}
