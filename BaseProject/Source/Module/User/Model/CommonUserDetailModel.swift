//
//  CommonUserDetailModel.swift
//  BaseProject
//
//  Created by zhaowei on 2019/6/24.
//  Copyright © 2019 ChainOne. All rights reserved.
//  用户详情公共模型模型

import Foundation
import ObjectMapper

class CommonUserDetailModel: Mappable {
    //用户id
    var id: Int = 0
    //用户昵称
    var name: String = ""
    //用户头像
    var avatar: String = ""
    //IMeet账号
    var number: String = ""
    //主页背景
    var background: String = ""
    //性别
    var sexValue: Int = 0
    //生日
    var birthday: String = ""
    //邀请码
    var invite_code: String = ""
    //矿力值
    var power: Int = 0
    /// 等级
//    var grade: GradeModel? // 等级？
    /// 个性签名
    var bio: String = ""

    /// 好友标记
    var is_friend: Bool = false
    /// 好友模型
//    var friend: FriendModel?

    var extra: UserExtraModel? = nil
    /// tags
//    var tags: [UserTagModel] = []

    /// 动态主动屏蔽设置(我的角度，而非该用户角度) - Int
    var shielding_lookme: Int = 0
    var shielding_lookhim: Int = 0
    ///
    var isShieldingLookme: Bool {
        return shielding_lookme == 1
    }
    var isShieldingLookhim: Bool {
        return shielding_lookhim == 1
    }

    /// 是否在黑名单中
    var isInBlackList: Bool = false

    var avatarUrl: URL? {
        return UrlManager.fileUrl(name: self.avatar)
    }
    var sex: UserSex {
        var sex: UserSex = UserSex.unknown
        if let userSex = UserSex.init(rawValue: self.sexValue) {
            sex = userSex
        }
        return sex
    }
    /// 是否大咖
    @objc public var big_name: Int = 0

    /// -> SimpleUserModel
    var simpleUser: SimpleUserModel? {
        return SimpleUserModel.init(id: self.id, name: self.name, sex: self.sex, avatarFileName: self.avatar, bigNameValue: self.big_name)
    }

    init() {

    }

    required init?(map: Map) {

    }
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        avatar <- map["avatar"]
        number <- map["number"]
        background <- map["background"]
        sexValue <- map["sex"]
        big_name <- map["big_name"]
        birthday <- map["birthday"]
        is_friend <- map["is_friend"]
        invite_code <- map["invite_code"]
        power <- map["power"]
        extra <- map["extra"]
//        tags <- map["tags"]
//        grade <- map["grade"]
        bio <- map["bio"]
//        friend <- map["friend"]
        shielding_lookme <- map["shielding.look_me"]
        shielding_lookhim <- map["shielding.look_him"]
        isInBlackList <- map["in_blacklist"]
    }

//    /// tag拼接
//    func tagJoin(with separator: String = " ") -> String? {
//        if self.tags.isEmpty {
//            return nil
//        }
//        var strTag: String = ""
//        for (index, tag) in self.tags.enumerated() {
//            if 0 == index {
//                strTag = tag.title
//            } else {
//                strTag += (separator + tag.title)
//            }
//        }
//        return strTag
//    }

}
