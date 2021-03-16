//
//  BKView.swift
//  
//
//  Created by Ethan Lipnik on 3/16/21.
//

#if canImport(UIKit)
import UIKit

public class BKView: UIView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.isHidden = true
        imageView.tintColor = UIColor.white
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        let font = UIFont.systemFont(ofSize: 20, weight: .bold)
        let fontDescriptor = font.fontDescriptor.withDesign(.rounded) ?? font.fontDescriptor
        let final = UIFont(descriptor: fontDescriptor, size: 20)
        label.font = final
        
        label.textColor = UIColor.white
        
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("BannerKit – Cannot initialize a banner in storyboards")
    }
    
    private func setup() {
        backgroundColor = UIColor.link
        layer.shadowColor = UIColor.link.withAlphaComponent(0.4).cgColor
        
        layer.cornerCurve = .continuous
        
        layer.cornerRadius = 25
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 5
        layer.shadowOpacity = 1
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        imageView.layer.shouldRasterize = true
        imageView.layer.rasterizationScale = UIScreen.main.scale
        
        titleLabel.layer.shouldRasterize = true
        titleLabel.layer.rasterizationScale = UIScreen.main.scale
        
        alpha = 0
        transform = .init(scaleX: 0.5, y: 0.5)
        
        addSubview(stackView)
        
        stackView.frame = bounds
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
    }
    
    public func show(withTitle title: String, icon: String? = nil, duration: Double = 3, tintColor: UIColor = UIColor.link) {
        
        hide()
        
        titleLabel.text = title
        backgroundColor = tintColor
        
        layer.shadowColor = tintColor.withAlphaComponent(0.4).cgColor
        
        if let icon = icon {
            
            imageView.isHidden = false
            imageView.image = UIImage(systemName: icon, withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))
        } else {
            imageView.isHidden = true
            imageView.image = nil
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.5, options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState], animations: { [weak self] in
            guard let self = self else { return }
            
            self.frame.origin.y = self.safeAreaInsets.top + 10
            self.center = self.superview?.center ?? .zero
            self.alpha = 1
            self.transform = .identity
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
            self?.hide()
        }
    }
    
    public func hide() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.5, options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState], animations: { [weak self] in
            guard let self = self else { return }
            
            self.frame.origin.y = -50
            self.alpha = 0
            self.transform = .init(scaleX: 0.5, y: 0.5)
        })
    }
}
#endif

