//
//  AccountLoginModel.swift
//  BaseProject
//
//  Created by 小唐 on 2019/1/22.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  账号登录数据模型

import Foundation
import ObjectMapper

class AccountLoginModel {
    /// 账号信息
    var account: String = ""
    /// 是否上次登录，所有账号中只能有一个是
    var isLast: Bool = false
    /// 是否登录，标记该账号是否登录，退出登录、无效登录、token过期、401token无效等都会作为未登录处理
    var isLogin: Bool = false

    init(account: String = "", isLast: Bool = false, isLogin: Bool = false) {
        self.account = account
        self.isLast = isLast
        self.isLogin = isLogin
    }

    // MARK: - Realm
    init(object: AccountLoginObject) {
        self.account = object.account
        self.isLast = object.isLast
        self.isLogin = object.isLogin
    }
    func object() -> AccountLoginObject {
        let object = AccountLoginObject()
        object.account = self.account
        object.isLast = self.isLast
        object.isLogin = self.isLogin
        return object
    }
}
