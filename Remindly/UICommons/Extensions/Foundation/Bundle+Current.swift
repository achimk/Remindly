
import Foundation

private final class BundleLoader { }

extension Bundle {
    
    static func current() -> Bundle {
        
        return Bundle(for: BundleLoader.self)
    }
}
