//
//  UITextField+Extension.swift
//  BaseProject
//
//  Created by 小唐 on 2019/7/24.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import Foundation
import UIKit


extension UITextField {

    func setPlaceHolder(_ placeholder: String, font: UIFont, color: UIColor) -> Void {
        //self.placeholder = nil
        self.attributedPlaceholder = NSAttributedString.init(string: placeholder, attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color])
    }

}
