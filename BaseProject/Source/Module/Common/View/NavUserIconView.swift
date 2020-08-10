//
//  NavUserIconView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/6/4.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  导航栏用户头像控件，用于主页自定义导航栏控件
//  注1：使用约束会出问题的解决，并参考之前的一个控件使用约束和frame在不同版本下的问题；
//  注2：其作为leftBarButtonItem时给该控件本身添加头像修改的通知时，能响应通知，但不能在通知里改变头像，需要重新赋值leftBarButtonItem。

import UIKit

/// 导航栏用户头像控件，点击事件需自己添加处理
class NavUserIconView: UIView {

    static let defaultBounds: CGRect = CGRect.init(x: 0, y: 0, width: 32, height: 32)
    // 点击事件自己添加处理
    let userIcon: UIButton = UIButton.init(type: .custom)

    init() {
        super.init(frame: NavUserIconView.defaultBounds)
        self.commonInit(frame: NavUserIconView.defaultBounds)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func commonInit(frame: CGRect) -> Void {
        self.isUserInteractionEnabled = false
        let userIcon: UIButton = UIButton.init(type: .custom)
        self.addSubview(userIcon)
        userIcon.frame = frame
        let minWH: CGFloat = min(frame.width, frame.height)
        userIcon.set(font: nil, cornerRadius: minWH * 0.5, borderWidth: 0, borderColor: UIColor.clear)
        userIcon.setBackgroundImage(AppImage.PlaceHolder.user_secrecy, for: .normal)
        userIcon.addTarget(self, action: #selector(userIconClick(_:)), for: .touchUpInside)
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: userView)
        let user = AccountManager.share.currentAccountInfo?.userInfo
        userIcon.kf.setBackgroundImage(with: user?.avatarUrl, for: .normal, placeholder: AppImage.placeHolder(for: user?.sex))
    }

    @objc func userIconClick(_ button: UIButton) -> Void {
        // 发送通知 弹出左侧弹窗
        NotificationCenter.default.post(name: Notification.Name.App.showLeftMenu, object: nil)
    }

}
