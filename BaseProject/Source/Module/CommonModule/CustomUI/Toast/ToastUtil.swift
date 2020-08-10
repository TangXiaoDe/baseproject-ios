//
//  Toast.swift
//  BaseProject
//
//  Created by 小唐 on 2019/4/9.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  Toast工具

import Foundation
import UIKit

typealias Toast = ToastUtil
class ToastUtil {

    static let defaultDuration: TimeInterval = 1.5
    static let defaultBottomMargin: CGFloat = 100 + kBottomHeight
    static let lrMinMargin: CGFloat = 30

    class func showToast(title: String?, on view: UIView? = nil, bottomMargin: CGFloat? = nil) -> Void {
        if RootManager.share.authIllicitAlertShowing {
            return
        }
        let toastView = ToastView()
        toastView.title = title
        self.showToast(toastView: toastView, on: view, bottomMargin: bottomMargin, duration: ToastUtil.defaultDuration)
    }
    class func showToast(toastView: ToastView, on view: UIView? = nil, bottomMargin: CGFloat? = nil, duration: TimeInterval? = nil) -> Void {
        if RootManager.share.authIllicitAlertShowing {
            return
        }
//        RootManager.share.alertWindow.makeKeyAndVisible()
        var superView: UIView = UIApplication.shared.keyWindow!
        if let view = view {
            superView = view
        }
        superView.addSubview(toastView)
        superView.bringSubviewToFront(toastView)
        toastView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(lrMinMargin)
            make.trailing.lessThanOrEqualToSuperview().offset(-lrMinMargin)
            if let bottomMargin = bottomMargin {
                make.bottom.equalToSuperview().offset(-bottomMargin)
            } else {
                make.centerY.equalToSuperview().multipliedBy(0.615 * 2.0)
            }
        }
        var toastDuration = ToastUtil.defaultDuration
        if let duration = duration {
            toastDuration = duration
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + toastDuration) {
            ToastUtil.removeToastAnimation(toastView: toastView, duration: 0.5)
        }
    }

    fileprivate class func removeToastAnimation(toastView: ToastView, duration: TimeInterval) -> Void {
        UIView.animate(withDuration: duration, animations: {
            toastView.alpha = 0
        }) { (finish) in
            if finish {
                toastView.removeFromSuperview()
//                RootManager.share.alertWindow.resignKey()
//                RootManager.share.mainWindow?.makeKeyAndVisible()
            }
        }
    }

}
