//
//  AccountModel.swift
//  BaseProject
//
//  Created by 小唐 on 2019/1/22.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  账号数据模型

import Foundation

typealias MultiAccountModel = AccountModel

class AccountModel {
    /// 账号
    var account: String

    /// token模型
    var token: AccountTokenModel?
    /// 登录信息
    var loginInfo: AccountLoginModel = AccountLoginModel()
    /// 当前用户信息
    var userInfo: CurrentUserModel?
    /// 账号设置信息(如指纹登录、主题色...)  暂无

    /// 是否是上次登录
    var isLast: Bool {
        return self.loginInfo.isLogin
    }

    init(account: String, token: AccountTokenModel, isLast: Bool, userInfo: CurrentUserModel?) {
        self.account = account
        self.token = token
        if let oldInfo = DataBaseManager().account.getAccountInfo(for: account) {
            self.loginInfo = oldInfo.loginInfo
        } else {
            self.loginInfo.account = account
        }
        self.loginInfo.isLast = isLast
        self.userInfo = userInfo
    }

    // MARK: - Realm
    init(object: AccountObject) {
        self.account = object.account
        if let token = object.token {
            self.token = AccountTokenModel(object: token)
        }
        if let loginInfo = object.loginInfo {
            self.loginInfo = AccountLoginModel.init(object: loginInfo)
        }
        if let userInfo = object.userInfo {
            self.userInfo = CurrentUserModel.init(object: userInfo)
        }
    }
    func object() -> AccountObject {
        let object = AccountObject()
        object.account = self.account
        object.token = self.token?.object()
        object.loginInfo = self.loginInfo.object()
        object.userInfo = self.userInfo?.object()
        return object
    }

}
