//
//  ILHButton.swift
//  TemplateLab
//
//  Created by 염태규 on 2022/11/27.
//

import Foundation
import UIKit

class ILVButton: BaseView {
    
    var image_main = UIImageView()
    var label_main = UILabel()
    
    override func initViews(parent: BaseViewController?) {
        addSubview(image_main)
        image_main.snp.makeConstraints { make in
            
        }
        
        addSubview(label_main)
        label_main.snp.makeConstraints { make in
            
        }
    }
}
