
import Foundation

public extension UIView {
    
    func setupAccesibilityIdentifier(_ identifier : String?, attributes: [String]? = nil) {
        guard let identifier = identifier else { return }
        
        var id = identifier
        
        self.isAccessibilityElement = true
        
        if let attributesArray = attributes {
            for attribute in attributesArray {
                id += "@" + attribute
            }
        }
        
        self.accessibilityIdentifier = id
    }
}
