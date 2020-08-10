//
//  CurrentUserModel.swift
//  BaseProject
//
//  Created by 小唐 on 2019/1/22.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  当前用户数据模型

import Foundation
import ObjectMapper
import RealmSwift

// TODO: - 用户性别应提取成单独文件，便于查找
/// 用户性别
enum UserSex: Int {
    /// 未知
    case unknown = 0
    /// 男
    case man = 1
    /// 女
    case woman = 2

    /// 性别描述
    var desc: String {
        var desc: String = ""
        switch self {
        case .unknown:
            desc = "保密"
        case .man:
            desc = "男"
        case .woman:
            desc = "女"
        }
        return desc
    }

    /// 他她它
    var ta: String {
        var desc: String = ""
        switch self {
        case .unknown:
            desc = "它"
        case .man:
            desc = "他"
        case .woman:
            desc = "她"
        }
        return desc
    }

    /// 图标
    var icon: UIImage? {
        var image: UIImage? = nil
        switch self {
        case .unknown:
            break
        case .man:
            image = UIImage.init(named: "IMG_icon_sex_men")
        case .woman:
            image = UIImage.init(named: "IMG_icon_sex_women")
        }
        return image
    }
    /// 占位图
    var placeholder: UIImage? {
        var image: UIImage? = UIImage.init(named: "IMG_icon_head_secrecy")
        switch self {
        case .unknown:
            image = UIImage.init(named: "IMG_icon_head_secrecy")
        case .man:
            image = UIImage.init(named: "IMG_icon_head_boy_default")
        case .woman:
            image = UIImage.init(named: "IMG_icon_head_girl_default")
        }
        return image
    }

}

/// 用户认证状态 - 设置页展示
enum UserCertificationStatus: String {
    /// 未认证
    case unCertified = "unCertified"
    /// 审核中
    case waiting = "waiting"
    /// 认证失败
    case failure = "failure"
    /// 已认证 - 认证成功
    case certified = "certified"

    var title: String {
        var title: String = ""
        switch self {
        case .unCertified:
            title = "未认证"
        case .waiting:
            title = "审核中"
        case .failure:
            title = "认证失败"
        case .certified:
            title = "已认证"
        }
        return title
    }

}


/// 当前用户
class CurrentUserModel: NSObject, Mappable {

    /// id
    @objc public var id: Int = 0
    /// 昵称
    @objc public var name: String = ""
    /// 性别 0-未知[保密] 1-男 2-女
    @objc public var sexValue: Int = 0
    /// 电话号码，[注]返回的电话号码中间4位数字处理过
    var phone: String = ""
    /// IMeet账号
    var number: String = ""
    /// 头像名称
    @objc public var avatar: String? = nil
    /// 是否大咖
    @objc public var big_name: Int = 0
    /// 背景链接
    var background: String? = nil
    /// 生日
    var birthday: String? = nil
    /// 环信登录密码
    var easemobPwd: String = ""
    /// 邀请码
    var inviteCode: String = ""
    /// 简介
    var bio: String = ""
    /// 矿力
    var power: Int = 0
    /// 是否设置过支付密码
    var payPwdStatus: Bool = false
    /// 推荐用户
    var recommender: RecommenderModel?
    /// extra
    var extra: UserExtraModel? = nil
    /// tags
//    var tags: [UserTagModel] = []

    /// 拥有CT数(矿石) - 非用户接口提供，而由别的接口提供
    var totalCT: Double = 0.0


    /// 性别
    var sex: UserSex {
        var sex: UserSex = UserSex.unknown
        if let userSex = UserSex.init(rawValue: self.sexValue) {
            sex = userSex
        }
        return sex
    }
    /// 认证状态
    var certStatusValue: String = ""    // 数据库存储字段
    var certStatus: UserCertificationStatus {
        var status = UserCertificationStatus.unCertified
        if let realStatus = UserCertificationStatus.init(rawValue: self.certStatusValue) {
            status = realStatus
        }
        return status
    }

    /// 头像链接
    var strAvatar: String? {
        return UrlManager.strFileUrl(name: self.avatar)
    }
    /// 头像url
    var avatarUrl: URL? {
        return UrlManager.fileUrl(name: self.avatar)
    }

    /// -> SimpleUserModel
    var simpleUser: SimpleUserModel? {
        return SimpleUserModel.init(id: self.id, name: self.name, sex: self.sex, avatarFileName: self.avatar, bigNameValue: self.big_name)
    }


    required init?(map: Map) {

    }
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        sexValue <- map["sex"]
        phone <- map["phone"]
        number <- map["number"]
        avatar <- map["avatar"]
        big_name <- map["big_name"]
        background <- map["background"]
        birthday <- map["birthday"]
        easemobPwd <- map["easemob_pass"]
        inviteCode <- map["invite_code"]
        bio <- map["bio"]
        power <- map["power"]
        payPwdStatus <- map["pay_pass_status"]
//        grade <- map["grade"]
        recommender <- map["parent"]
        extra <- map["extra"]
//        tags <- map["tags"]
//        chain <- map["upper_chain"]
    }

    // MARK: - Realm
    init(object: CurrentUserObject) {
        self.id = object.id
        self.name = object.name
        self.sexValue = object.sexValue
        self.phone = object.phone
        self.number = object.number
        self.avatar = object.avatar
        self.big_name = object.big_name
        self.background = object.background
        self.birthday = object.birthday
        self.easemobPwd = object.easemobPwd
        self.inviteCode = object.inviteCode
        self.bio = object.bio
        self.power = object.power
        self.payPwdStatus = object.payPwdStatus
        self.certStatusValue = object.certStatusValue
        if let extra = object.extra {
            self.extra = UserExtraModel.init(object: extra)
        }
//        for tagObject in object.tags {
//            self.tags.append(UserTagModel.init(object: tagObject))
//        }
        if let recommenderObject = object.recommender {
            self.recommender = RecommenderModel.init(object: recommenderObject)
        }
//        if let grade = object.grade {
//            self.grade = GradeModel.init(object: grade)
//        }
//        if let chain = object.chain {
//            self.chain = UserUpChainModel.init(object: chain)
//        }
    }
    func object() -> CurrentUserObject {
        let object = CurrentUserObject()
        object.id = self.id
        object.name = self.name
        object.sexValue = self.sexValue
        object.phone = self.phone
        object.number = self.number
        object.avatar = self.avatar
        object.big_name = self.big_name
        object.background = self.background
        object.birthday = self.birthday
        object.easemobPwd = self.easemobPwd
        object.inviteCode = self.inviteCode
        object.bio = self.bio
        object.power = self.power
        object.payPwdStatus = self.payPwdStatus
        object.extra = self.extra?.object()
        object.recommender = self.recommender?.object()
//        object.grade = self.grade?.object()
        object.certStatusValue = self.certStatusValue
//        object.chain = self.chain?.object()
//        for tagModel in self.tags {
//            object.tags.append(tagModel.object())
//        }
        return object
    }

    /// tag拼接
    func tagJoin(with separator: String = " ") -> String? {
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
        return nil
    }

}
