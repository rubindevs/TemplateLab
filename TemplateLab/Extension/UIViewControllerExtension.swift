//
//  UIViewControllerExtension.swift
//  TemplateLab
//
//  Created by 염태규 on 2022/11/28.
//

import Foundation
import UIKit

extension UIViewController {
    
    func has(_ viewController: UIViewController) -> Bool {
        return children.contains(viewController)
    }
    
    func add(_ viewController: UIViewController, view: UIView? = nil, topView: UIView? = nil) {
        addChild(viewController)
        (view ?? self.view).addSubview(viewController.view)
        viewController.view.snp.makeConstraints { make in
            if let topView = topView {
                make.top.equalTo(topView.snp.bottom)
            } else {
                make.top.equalToSuperview()
            }
            make.leading.trailing.bottom.equalToSuperview()
        }
        viewController.didMove(toParent: self)
    }
    
    func replace(_ from: UIViewController, _ to: UIViewController, _ view: UIView) {
        remove(from)
        add(to, view: view)
    }
    
    func remove(_ viewController: UIViewController) {
        guard children.contains(viewController) else { return }
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}
