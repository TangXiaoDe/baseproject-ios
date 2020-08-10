//
//  SimpleUserModel.swift
//  BaseProject
//
//  Created by 小唐 on 2019/6/12.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  简单用户数据模型

import Foundation
import ObjectMapper


// 简单用户数据模型
class SimpleUserModel: NSObject, Mappable {

    /// 用户id
    @objc var id: Int = 0
    /// 用户id
    @objc var objcID: Int = 0
    /// 用户名称
    @objc var name: String = ""
    // TODO: - 将类似的命名中的filename去除，仅保留通用中的这种命名，使其更具普适性。
    /// 头像文件名称
    var avatarFileName: String? = nil
    /// 是否是好友
    var isFriend: Bool = false
    /// 等级
//    var grade: GradeModel? // 等级？

    /// 手机号
    var phone: String? = nil
    /// iMeet账号
    var number: String = ""
    /// 性别
    var sexValue: Int = 0
    /// 好友申请状态 - 动态中的推荐用户时才存在该字段
    var applyStatus: Bool = false


    /// 性别
    var sex: UserSex {
        var sex: UserSex = UserSex.unknown
        if let userSex = UserSex.init(rawValue: self.sexValue) {
            sex = userSex
        }
        return sex
    }
    /// 头像链接
    var strAvatar: String? {
        return UrlManager.strFileUrl(name: self.avatarFileName)
    }
    /// 头像url
    var avatarUrl: URL? {
        return UrlManager.fileUrl(name: self.avatarFileName)
    }

//    /// 1 大咖 0不是
//    var bigNameValue: Int = 0
//    var bigNameStatus: BigNameStatus {
//        var status: BigNameStatus = .none
//        if let realStatus = BigNameStatus.init(rawValue: self.bigNameValue) {
//            status = realStatus
//        }
//        return status
//    }

    /// 是否选中
    var isSelected: Bool = false

    override init() {

    }

    init(id: Int, name: String, sex: UserSex, avatarFileName: String?, bigNameValue: Int) {
        super.init()
        self.id = id
        self.objcID = id
        self.name = name
        self.sexValue = sex.rawValue
        self.avatarFileName = avatarFileName
//        self.bigNameValue = bigNameValue
    }

    required init?(map: Map) {

    }
    func mapping(map: Map) {
        id <- map["id"]
        objcID <- map["id"]
        name <- map["name"]
//        grade <- map["grade"]
        avatarFileName <- map["avatar"]
        phone <- map["phone"]
        number <- map["number"]
        sexValue <- map["sex"]
        applyStatus <- map["apply_status"]
//        bigNameValue <- map["big_name"]
        isFriend <- map["is_friend"]
    }

}
