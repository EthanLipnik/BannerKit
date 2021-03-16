#if canImport(UIKit)
import UIKit

public class BannerKit {
    public static let shared = BannerKit()
    var bannerView: BKView
    
    private var topConstraint: NSLayoutConstraint? = nil
    
    private init() {
        bannerView = BKView()
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        
        UIApplication.shared.keyWindow?.addSubview(bannerView)
        
        topConstraint = NSLayoutConstraint(item: bannerView, attribute: .top, relatedBy: .equal, toItem: UIApplication.shared.keyWindow, attribute: .top, multiplier: 1, constant: -50)
        
        UIApplication.shared.keyWindow?.addConstraints([
            topConstraint!,
            
            NSLayoutConstraint(item: bannerView, attribute: .leadingMargin, relatedBy: .greaterThanOrEqual, toItem: UIApplication.shared.keyWindow, attribute: .leadingMargin, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: bannerView, attribute: .trailingMargin, relatedBy: .lessThanOrEqual, toItem: UIApplication.shared.keyWindow, attribute: .trailingMargin, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: bannerView, attribute: .centerX, relatedBy: .equal, toItem: UIApplication.shared.keyWindow, attribute: .centerX, multiplier: 1, constant: 0),
            
            NSLayoutConstraint(item: bannerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: bannerView, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 75)
        ])
    }
    
    public func show(withTitle title: String, icon: String? = nil, duration: Double = 3, tintColor: UIColor = UIColor.link) {
        UIApplication.shared.keyWindow?.bringSubviewToFront(bannerView)
        
        guard let topConstraint = self.topConstraint else { return }
        
        bannerView.show(withTitle: title, icon: icon, duration: duration, tintColor: tintColor, topConstraint: topConstraint)
    }
    
    public func hide() {
        guard let topConstraint = self.topConstraint else { return }
        
        bannerView.hide(topConstraint: topConstraint)
    }
}
#endif
