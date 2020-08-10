//
//  LoginRegisterType.swift
//  BaseProject
//
//  Created by 小唐 on 2019/5/30.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  登录注册类型

import Foundation

/// 登录注册类型
enum LoginRegisterType {
    case login
    case register

    var title: String {
        var title: String = ""
        switch self {
        case .login:
            title = "navbar.title.pwdlogin".localized
        case .register:
            title = "navbar.title.register".localized
        }
        return title
    }
}

/// 登录类型
enum LoginType {
    case password
    case smscode
    var title: String {
        var title: String = ""
        switch self {
        case .password:
            title = "navbar.title.pwdlogin".localized
        case .smscode:
            title = "navbar.title.smslogin".localized
        }
        return title
    }
}
