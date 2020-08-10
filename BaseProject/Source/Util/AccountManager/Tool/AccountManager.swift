//
//  AccountManager.swift
//  BaseProject
//
//  Created by 小唐 on 2019/1/22.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  登录账户管理

import Foundation

/// 账号管理
class AccountManager: NSObject {
    /// 单例构造
    static let share = AccountManager()
    private override init() {
        super.init()
        // 获取之前登录用户
        self.currentAccountInfo = DataBaseManager().account.getLastLoginedAccountInfo()
        self.setDefaultAccountInfo()
    }
    //给 oc代码调用的
    @objc public static func getCurrentInfo() -> CurrentUserModel? {
        return AccountManager.share.currentAccountInfo?.userInfo
    }

    /// 是否登录——游客判断
    var isLogin: Bool {
        var loginFlag: Bool = false
        if let _ = self.currentAccountInfo {
            loginFlag = true
        }
        return loginFlag
    }

    /// 当前登录账号：使用token的那个账号，可能机构也可能普通用户
    var currentAccountInfo: AccountModel? {
        didSet {
            self.setDefaultAccountInfo()
        }
    }

    /// 根据当前账号信息进行默认配置，主要用于默认登录
    fileprivate func setDefaultAccountInfo() -> Void {
        NetworkManager.share.configAuthorization(self.currentAccountInfo?.token?.token)
    }

}

// MARK: - 获取
extension AccountManager {
    /// 获取登录账号列表
    func getAllAccountInfos() -> [AccountModel] {
        return DataBaseManager().account.getAllAccountInfos()
    }
    /// 获取最后登录的账号，且当前一定是登录状态
    func getLastLoginedAccountInfo() -> AccountModel? {
        return DataBaseManager().account.getLastLoginedAccountInfo()
    }
    /// 获取最后一次登录的账号：但当前不一定是登录状态
    func getLasAccountInfo() -> AccountModel? {
        return DataBaseManager().account.getLastAccountInfo()
    }
    /// 获取可切换账号信息列表
    func getSwitchableAccountList() -> [AccountModel] {
        return DataBaseManager().account.getSwitchableAccountInfo()
    }
    /// 获取指定账号的账号信息
    func getAccountInfo(for account: String) -> AccountModel? {
        return DataBaseManager().account.getAccountInfo(for: account)
    }

}

// MARK: - 增加
extension AccountManager {
    /// 添加登录账号
    func addLoginAccountInfo(_ accountInfo: AccountModel) -> Void {
        accountInfo.loginInfo.isLast = true
        accountInfo.loginInfo.isLogin = true
        DataBaseManager().account.saveAccountInfo(accountInfo)
        self.currentAccountInfo = accountInfo
    }
}

// MARK: - 修改
extension AccountManager {
    /// 修改账号信息
    func updateAccountInfo(_ accountInfo: AccountModel) -> Void {
        DataBaseManager().account.updateAccountInfo(accountInfo)
    }

    /// 修改指定账号的token信息
    func updateAccountInfo(for account: String, token: AccountTokenModel?) -> Void {
        DataBaseManager().account.updateAccountInfo(for: account, token: token)
    }
    /// 修改指定账号的login信息
    func updateAccountInfo(for account: String, loginInfo: AccountLoginModel) -> Void {
        DataBaseManager().account.updateAccountInfo(for: account, loginInfo: loginInfo)
    }
    /// 修改指定账号的userInfo信息
    func updateAccountInfo(for account: String, userInfo: CurrentUserModel) -> Void {
        DataBaseManager().account.updateAccountInfo(for: account, userInfo: userInfo)
    }

    /// 修改当前登录账号的信息
    func updateCurrentAccount(userInfo: CurrentUserModel) -> Void {
        if let account = self.currentAccountInfo?.account {
            self.updateAccountInfo(for: account, userInfo: userInfo)
        }
        self.currentAccountInfo?.userInfo = userInfo
    }
    func updateCurrentAccount(token: AccountTokenModel) -> Void {
        if let account = self.currentAccountInfo?.account {
            self.updateAccountInfo(for: account, token: token)
        }
        self.currentAccountInfo?.token = token
        NetworkManager.share.configAuthorization(token.token)
    }

}

// MARK: - 移除
extension AccountManager {
    /// 移除指定账号及其相关信息
    func removeLoginAccountInfo(for account: String) -> Void {
        // 如果是当前登录用户，则不可移除
        if self.currentAccountInfo?.account == account {
            fatalError("当前登录用户不可移除")
        }
        // 数据库中于该account相关更新: token、登录信息设置、
        if let accountInfo: AccountModel = DataBaseManager().account.getAccountInfo(for: account) {
            accountInfo.token = nil
            accountInfo.loginInfo.isLast = false
            accountInfo.loginInfo.isLogin = false
            DataBaseManager().account.updateAccountInfo(accountInfo)
        }
    }
}

// MARK: - 切换
extension AccountManager {
    /// 登录用户切换-仅针对普通用户
    func switchLoginUser(to accountInfo: AccountModel) -> Void {
        // 之前账号的用户处理
        if let oldAccountInfo = self.currentAccountInfo {
            oldAccountInfo.loginInfo.isLast = false
            DataBaseManager().account.updateAccountInfo(oldAccountInfo)
        }
        // 新账号处理
        accountInfo.loginInfo.isLast = true
        accountInfo.loginInfo.isLogin = true
        self.currentAccountInfo = accountInfo
        DataBaseManager().account.updateAccountInfo(accountInfo)
    }
}

// MARK: - 移除
extension AccountManager {
    /// 退出登录处理——对当前登录账号处理
    func logoutProcess() -> Void {
        // 数据库中于该account相关更新: token、登录信息设置、
        if let accountInfo: AccountModel = self.currentAccountInfo {
            accountInfo.token = nil
            accountInfo.loginInfo.isLast = true
            accountInfo.loginInfo.isLogin = false
            DataBaseManager().account.updateAccountInfo(accountInfo)
        }
        self.currentAccountInfo = nil
    }

}
