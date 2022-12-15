//
//  ViewExtension.swift
//  nextm
//
//  Created by 염태규 on 2022/10/08.
//

import Foundation
import UIKit
import SnapKit

enum FontFamily {
    case Montserrat
    
    func get(_ iphoneSize: CGFloat, _ weight: Int) -> UIFont {
        var size = iphoneSize
        if weight == 400 {
            return UIFont(name: "Montserrat-Regular", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
        } else if weight == 500 {
            return UIFont(name: "Montserrat-Medium", size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
        } else if weight == 600 {
            return UIFont(name: "Montserrat-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .semibold)
        } else if weight == 700 {
            return UIFont(name: "Montserrat-Bold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
        } else {
            return UIFont(name: "Montserrat-Regular", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
        }
    }
}

extension UIView {
    func setText(_ text: String, _ color: UIColor, _ font: UIFont, state: UIControl.State = .normal) {
        if let label = self as? UILabel {
            label.text = text
            label.textColor = color
            label.font = font
        } else if let button = self as? UIButton {
            button.titleLabel?.font = font
            button.setTitle(text, for: state)
            button.setTitleColor(color, for: state)
        } else if let textfield = self as? UITextField {
            textfield.text = text
            textfield.textColor = color
            textfield.font = font
        } else if let textview = self as? UITextView {
            textview.text = text
            textview.textColor = color
            textview.font = font
        }
    }
    
    func setAttribute(_ attributes: [(attr: Attribute, value: Any, range: NSRange?)], text: String? = nil) {
        if let label = self as? UILabel {
            if let text = text ?? label.text {
                let attributedString = NSMutableAttributedString(string: text)
                for attribute in attributes {
                    if let value = attribute.value as? CGFloat, let paragraphStyle = attribute.attr.getParagraphStyle(value) {
                        attributedString.addAttribute(attribute.attr.attributeKey, value: paragraphStyle, range: attribute.range ?? NSMakeRange(0, attributedString.length))
                    } else {
                        attributedString.addAttribute(attribute.attr.attributeKey, value: attribute.value, range: attribute.range ?? NSMakeRange(0, attributedString.length))
                    }
                }
                label.attributedText = attributedString
            } else {
                print("use after setText!!")
            }
        } else if let button = self as? UIButton {
            if let text = text ?? button.titleLabel?.text {
                let attributedString = NSMutableAttributedString(string: text)
                for attribute in attributes {
                    if let value = attribute.value as? CGFloat, let paragraphStyle = attribute.attr.getParagraphStyle(value) {
                        attributedString.addAttribute(attribute.attr.attributeKey, value: paragraphStyle, range: attribute.range ?? NSMakeRange(0, attributedString.length))
                    } else {
//                        print(text, attribute.attr, attribute.value, attribute.range)
                        attributedString.addAttribute(attribute.attr.attributeKey, value: attribute.value, range: attribute.range ?? NSMakeRange(0, attributedString.length))
                    }
                }
                button.setAttributedTitle(attributedString, for: .normal)
            } else {
                print("use after setText!!")
            }
        }
    }
    
    func setDash(frame: CGRect) {
        let yourViewBorder = CAShapeLayer()
//        yourViewBorder.strokeColor = UIColor.gray[13].cgColor
        yourViewBorder.lineDashPattern = [3, 3]
        yourViewBorder.frame = frame
        yourViewBorder.fillColor = nil
        yourViewBorder.path = UIBezierPath(rect: frame).cgPath
        self.layer.addSublayer(yourViewBorder)
    }
}

enum Attribute: String {
    case font = "bold" // UIFont
    case color = "color" // UIColor
    case lineSpacing = "lineSpacing" // cgfloat
    case characterSpacing = "characterSpacing" // double
    case underlineStyle = "underlineStyle" // NSUnderlineStyle.single.rawValue
    case underlineColor = "underlineColor" // UIColor
    
    var attributeKey: NSAttributedString.Key {
        switch (self) {
        case .font: return .font
        case .color: return .foregroundColor
        case .lineSpacing: return .paragraphStyle
        case .characterSpacing: return .kern
        case .underlineStyle: return .underlineStyle
        case .underlineColor: return .underlineColor
        }
    }
    
    func getParagraphStyle(_ value: CGFloat) -> NSParagraphStyle? {
        if self == .lineSpacing {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = value
            return paragraphStyle
        } else {
            return nil
        }
    }
}

extension UILabel {
    func setGradient() {
        let image = UIImage(named: "image_gradient")
        self.textColor = UIColor.init(patternImage: image!)
    }
}

extension UIButton {
    func setImage(_ image: String, _ color: UIColor? = nil) {
        subviews.forEach {
            if $0 is UIImageView {
                $0.removeFromSuperview()
            }
        }
        let imageView = UIImageView()
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        imageView.setImage(image, color)
    }
}

extension UIImageView {
    func setImage(_ image: String, _ color: UIColor? = nil) {
        if let color = color {
            self.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
            self.tintColor = color
        } else {
            self.image = UIImage(named: image)
        }
    }
}

extension UITextField {
    var forcedText: String {
        return self.text ?? ""
    }
}
