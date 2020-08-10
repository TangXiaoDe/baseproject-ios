//
//  PopViewUtil.swift
//  BaseProject
//
//  Created by 小唐 on 2019/7/23.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  弹窗工具，对BasePopView的子类显示与消失处理

import Foundation
import UIKit

class PopViewUtil {

    static let defaultDuration: TimeInterval = 1.5

    class func showPopView(_ popView: UIView, on view: UIView? = nil, duration: TimeInterval? = nil) -> Void {
        var superView: UIView = UIApplication.shared.keyWindow!
        if let view = view {
            superView = view
        }
        superView.addSubview(popView)
        superView.bringSubviewToFront(popView)
        popView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        if let duration = duration {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
                PopViewUtil.removePopViewAnimation(popView: popView, duration: 0.5)
            }
        }
    }

    fileprivate class func removePopViewAnimation(popView: UIView, duration: TimeInterval) -> Void {
        UIView.animate(withDuration: duration, animations: {
            popView.alpha = 0
        }) { (finish) in
            if finish {
                popView.removeFromSuperview()
            }
        }
    }

}
