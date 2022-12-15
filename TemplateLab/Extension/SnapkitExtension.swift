//
//  SnapkitExtension.swift
//  TemplateLab
//
//  Created by 염태규 on 2022/11/27.
//
import UIKit
import SnapKit

public extension ConstraintViewDSL {
    
    func makeEasyConstraints(topView: UIView? = nil, bottomView: UIView? = nil, leadingView: UIView? = nil, trailingView: UIView? = nil, completion: (_ width: Int, _ height: Int) -> Void, _ formats: [String]) {
        self.makeConstraints { make in
            var fixedWidth = 0
            var fixedHeight = 0
            for format in formats {
                let operation = format[format.startIndex]
                let inherition = format[format.index(after: format.startIndex)] == "s" // s : inherit
                let offset = Int(format[format.index(format.startIndex, offsetBy: inherition ? 2 : 1)...]) ?? 0
                switch operation {
                case "l":
                    if leadingView != nil {
                        make.leading.equalTo(leadingView!.snp.trailing).offset(offset)
                    } else {
                        make.leading.equalBy(inherition, offset)
                    }
                case "r":
                    if trailingView != nil {
                        make.trailing.equalTo(trailingView!.snp.leading).offset(offset)
                    } else {
                        make.trailing.equalBy(inherition, offset)
                    }
                case "t":
                    if topView != nil {
                        make.top.equalTo(topView!.snp.bottom).offset(offset)
                    } else {
                        make.top.equalBy(inherition, offset)
                    }
                case "b":
                    if bottomView != nil {
                        make.top.equalTo(bottomView!.snp.top).offset(offset)
                    } else {
                        make.bottom.equalBy(inherition, offset)
                    }
                case "w":
                    fixedWidth = offset
                    make.width.equalBy(inherition, offset)
                case "h":
                    fixedHeight = offset
                    make.height.equalBy(inherition, offset)
                case "x":
                    make.centerX.equalBy(inherition, offset)
                case "y":
                    make.centerY.equalBy(inherition, offset)
                default:
                    break
                }
            }
            completion(fixedWidth, fixedHeight)
        }
    }
    
    func makeEasyConstraints(topView: UIView? = nil, bottomView: UIView? = nil, leadingView: UIView? = nil, trailingView: UIView? = nil, completion: (_ width: Int, _ height: Int) -> Void, _ formats: String...) {
        makeEasyConstraints(topView: topView, bottomView: bottomView, leadingView: leadingView, trailingView: trailingView, completion: completion, formats)
    }
}

extension ConstraintMakerExtendable {
    
    func equalBy(_ inherition: Bool, _ offset: Int) {
        if inherition {
            equalToSuperview().offset(offset)
        } else {
            if offset != 0 {
                equalTo(offset)
            }
        }
    }
}
