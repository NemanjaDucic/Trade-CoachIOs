//
//  UIView + Extensions.swift
//  Trade-Coach
//
//  Created by Nemanja Ducic on 20.10.23..
//

import Foundation
import UIKit
extension UIViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
}
    
}
extension UIActivityIndicatorView {

var imageSize: CGSize {
    let imgView = subviews.first { $0 is UIImageView }
    return imgView?.bounds.size ?? .zero
}

var radius: CGFloat {
    get {
        imageSize.width * scale / 2.0
    }
    set {
        let w = imageSize.width
        scale = (w == 0.0) ? 0 : newValue * 2.0 / w
    }
}

var scale: CGFloat {
    get {

        transform.a
    }
    set {
        transform = CGAffineTransform(scaleX: newValue, y: newValue);
    }
}
 
}
extension UITextView {
    func setHyperlink(text: String, link: String) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: link, range: NSRange(location: 0, length: text.count))
        self.attributedText = attributedString
        self.isEditable = false
        self.isSelectable = true
        self.dataDetectorTypes = .link
    }
}
extension UILabel {
    func setHyperlink(text: String, link: String) {
        let attributedString = NSMutableAttributedString(string: text)
        let range = NSRange(location: 0, length: text.count)
        attributedString.addAttribute(.link, value: link, range: range)
        self.attributedText = attributedString
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        if let attributedText = self.attributedText, let link = attributedText.attribute(.link, at: 0, effectiveRange: nil) as? String {
            if let url = URL(string: link) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
class VerticalAlignedLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        var newRect = rect
        switch contentMode {
        case .top:
            newRect.size.height = sizeThatFits(rect.size).height
        case .bottom:
            let height = sizeThatFits(rect.size).height
            newRect.origin.y += rect.size.height - height
            newRect.size.height = height
        default:
            ()
        }
        
        super.drawText(in: newRect)
    }
}
extension UITextField {
 
    func setupImageRight(image:String){
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageView.image = UIImage(named: image)
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
        container.addSubview(imageView)
        rightView = container
        rightViewMode = .always
        self.tintColor = .lightGray
    }
    func setupImageRightLong(image:String){
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 20))
        imageView.image = UIImage(named: image)
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
        container.addSubview(imageView)
        rightView = container
        rightViewMode = .always
      
        self.tintColor = .lightGray
    }
    
}

