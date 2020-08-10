//
//  RecommenderModel.swift
//  BaseProject
//
//  Created by 小唐 on 2019/1/23.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  推荐人数据模型

import Foundation
import ObjectMapper
import RealmSwift

typealias UserRecommenderModel = RecommenderModel
typealias ParentUserModel = RecommenderModel
/// 邀请用户
class RecommenderModel: Mappable {

    /// 用户id
    var id: Int = 0
    /// 用户名称
    var name: String = ""
    /// 用户头像
    var avatar: String = ""
    /// 邀请时间
    var invitedDate: Date = Date()

    var strAvatarUrl: String? {
        return UrlManager.strFileUrl(name: self.avatar)
    }
    var avatarUrl: URL? {
        return UrlManager.fileUrl(name: self.avatar)
    }

    required init?(map: Map) {

    }
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        avatar <- map["avatar"]
        invitedDate <- (map["invited_at"], DateStringTransform.init(timeZone: TimeZone.current, dateFormat: "yyyy-MM-dd HH:mm:ss"))
    }

    // MARK: - Realm
    init(object: RecommenderObject) {
        self.id = object.id
        self.name = object.name
        self.avatar = object.avatar
        self.invitedDate = object.invitedDate
    }
    func object() -> RecommenderObject {
        let object = RecommenderObject()
        object.id = self.id
        object.name = self.name
        object.avatar = self.avatar
        object.invitedDate = self.invitedDate
        return object
    }

    func toUser() -> SimpleUserModel {
        let user = SimpleUserModel()
        user.id = self.id
        user.name = self.name
        user.avatarFileName = self.avatar
        return user
    }

}
