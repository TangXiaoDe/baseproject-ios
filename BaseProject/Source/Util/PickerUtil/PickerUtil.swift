//
//  PickerUtil.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/20.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  Picker工具

import Foundation
import UIKit

class PickerUtil {

    class func showPickerPopView(_ popView: PickerPopView, on view: UIView? = nil) -> Void {
        if let view = view {
            view.addSubview(popView)
            popView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        } else {
            UIApplication.shared.keyWindow?.addSubview(popView)
            popView.frame = UIScreen.main.bounds
        }
    }

}
