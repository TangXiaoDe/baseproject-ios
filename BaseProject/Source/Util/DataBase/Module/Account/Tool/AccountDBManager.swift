//
//  AccountDBManager.swift
//  BaseProject
//
//  Created by 小唐 on 2019/1/22.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  账号的数据库管理

import Foundation
import RealmSwift

class AccountDBManager {

    fileprivate let realm: Realm!

    // MARK: - Lifecycle
    init() {
        let realm = try! Realm()
        self.realm = realm
    }

    /// 删除整个表
    func deleteAll() {
        self.deleteAllAccountInfo()
    }

}

// MARK: - 获取已登录账号信息
extension AccountDBManager {
    /// 获取指定账号的登录信息
    func getAccountInfo(for account: String) -> AccountModel? {
        guard let object = realm.object(ofType: AccountObject.self, forPrimaryKey: account) else {
            return nil
        }
        return AccountModel(object: object)
    }

    /// 获取账号登录信息列表，传nil则获取所有的
    func getAllAccountInfos() -> [AccountModel] {
        var models: [AccountModel] = []
        let objects = realm.objects(AccountObject.self)
        for object in objects {
            let model = AccountModel.init(object: object)
            models.append(model)
        }
        return models
    }

    /// 获取最后一个且登录状态的账号信息：一定是登录状态
    func getLastLoginedAccountInfo() -> AccountModel? {
        var models: [AccountModel] = []
        let predicate: NSPredicate = NSPredicate(format: "loginInfo.isLast == true AND loginInfo.isLogin == true")
        let objects = realm.objects(AccountObject.self).filter(predicate)
        for object in objects {
            let model = AccountModel.init(object: object)
            models.append(model)
        }
        return models.first
    }

    /// 获取最后一个账号的登录信息: 不一定是登录状态
    func getLastAccountInfo() -> AccountModel? {
        var models: [AccountModel] = []
        let predicate: NSPredicate = NSPredicate(format: "loginInfo.isLast == true")
        let objects = realm.objects(AccountObject.self).filter(predicate)
        for object in objects {
            let model = AccountModel.init(object: object)
            models.append(model)
        }
        return models.first
    }

    /// 获取isLast为true的账号的登录信息列表: 不一定是登录状态
    fileprivate func getLastAccountInfos() -> [AccountModel] {
        var models: [AccountModel] = []
        let predicate: NSPredicate = NSPredicate(format: "loginInfo.isLast == true")
        let objects = realm.objects(AccountObject.self).filter(predicate)
        for object in objects {
            let model = AccountModel.init(object: object)
            models.append(model)
        }
        return models
    }

    /// 获取可切换的账号列表: 登录状态
    func getSwitchableAccountInfo() -> [AccountModel] {
        var models: [AccountModel] = []
        let predicate: NSPredicate = NSPredicate(format: "loginInfo.isLogin == true")
        let objects = realm.objects(AccountObject.self).filter(predicate)
        for object in objects {
            let model = AccountModel.init(object: object)
            models.append(model)
        }
        return models
    }
}

// MARK: - 修改已登录账号信息
extension AccountDBManager {
    /// 保存指定账号的登录信息
    func saveAccountInfo(_ model: AccountModel) -> Void {
        self.updateAccountInfo(model)
    }
    /// 更新指定账号的登录信息
    func updateAccountInfo(_ model: AccountModel) -> Void {
        // 如果当前账号的isLast为true，则其余账号的isLast修改为false
        if model.isLast {
            let models = self.getLastAccountInfos()
            var objects: [AccountObject] = []
            for model in models {
                model.loginInfo.isLast = false
                objects.append(model.object())
            }
            realm.beginWrite()
            realm.add(objects, update: true)
            try! realm.commitWrite()
        }
        // 更新当前账号的信息
        let object = model.object()
        realm.beginWrite()
        realm.add(object, update: true)
        try! realm.commitWrite()
    }

    /// 更新token信息
    func updateAccountInfo(for account: String, token: AccountTokenModel?) -> Void {
        guard let accountInfo = self.getAccountInfo(for: account) else {
            return
        }
        accountInfo.token = token
        self.updateAccountInfo(accountInfo)
    }
    /// 更新login信息
    func updateAccountInfo(for account: String, loginInfo: AccountLoginModel) -> Void {
        guard let accountInfo = self.getAccountInfo(for: account) else {
            return
        }
        accountInfo.loginInfo = loginInfo
        self.updateAccountInfo(accountInfo)
    }
    /// 更新userInfo信息
    func updateAccountInfo(for account: String, userInfo: CurrentUserModel) -> Void {
        guard let accountInfo = self.getAccountInfo(for: account) else {
            return
        }
        accountInfo.userInfo = userInfo
        self.updateAccountInfo(accountInfo)
    }

}

// MARK: - 删除已登录账号信息
extension AccountDBManager {

    /// 删除指定账号的登录信息
    func deleteAccountInfo(for account: String) -> Void {
        guard let object = realm.object(ofType: AccountObject.self, forPrimaryKey: account) else {
            return
        }
        try! realm.write {
            realm.delete(object)
        }
    }

    /// 删除所有的登录信息
    func deleteAllAccountInfo() -> Void {
        let objects = realm.objects(AccountObject.self)
        try! realm.write {
            realm.delete(objects)
        }
    }

}
