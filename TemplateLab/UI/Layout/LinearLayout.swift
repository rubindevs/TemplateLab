//
//  LinearLayout.swift
//  TemplateLab
//
//  Created by 염태규 on 2022/11/27.
//

import Foundation
import UIKit

class LinearLayout: BaseView {
    
    func addSubview(view: BaseView, topMargin: CGFloat) {
        view.snp.updateConstraints { make in
            if let lastView = subviews.last {
                make.top.equalTo(lastView.snp.bottom).offset(topMargin)
            } else {
                make.top.equalToSuperview()
            }
        }
    }
    
    override func addSubview(_ view: UIView) {
        super.addSubview(view)
    }
    
    override var height: CGFloat {
        return subviews.map { $0 as! BaseView }.reduce(0) { $0 + $1.height }
    }
}
