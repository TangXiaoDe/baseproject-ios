//
//  AccountTokenModel.swift
//  BaseProject
//
//  Created by 小唐 on 2019/1/22.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  Token数据模型

import Foundation
import ObjectMapper

class AccountTokenModel: Mappable {

    var token: String = ""
    /// 不返回，手动添加
    var account: String = ""

    required init?(map: Map) {

    }
    func mapping(map: Map) {
        token <- map["token"]
    }

    init(account: String = "", token: String = "") {
        self.account = account
        self.token = token
    }

    // MARK: - Realm
    init(object: AccountTokenObject) {
        self.token = object.token
        self.account = object.account
    }
    func object() -> AccountTokenObject {
        let object = AccountTokenObject()
        object.token = self.token
        object.account = self.account
        return object
    }
}
