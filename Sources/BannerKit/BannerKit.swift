#if canImport(UIKit)
import UIKit

public class BannerKit {
    static let shared = BannerKit()
    var bannerView: BKView
    
    private init() {
        bannerView = BKView()
        bannerView.frame = CGRect(x: 0, y: -50, width: 300, height: 50)
        
        UIApplication.shared.keyWindow?.addSubview(bannerView)
    }
    
    public func show(withTitle title: String, icon: String? = nil, duration: Double = 3, tintColor: UIColor = UIColor.link) {
        UIApplication.shared.keyWindow?.bringSubviewToFront(bannerView)
        
        bannerView.show(withTitle: title, icon: icon, duration: duration, tintColor: tintColor)
    }
    
    public func hide() {
        bannerView.hide()
    }
}
#endif
