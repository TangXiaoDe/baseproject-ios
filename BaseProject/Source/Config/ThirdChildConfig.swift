//
//  ThirdChildConfig.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2019/1/10.
//  Copyright © 2019 TangXiaoDe. All rights reserved.
//
//  三方子节点配置 即 具体的三方配置节点

import Foundation
import ObjectMapper

/// 仅含AppId的三方配置 - 暂未使用
struct ThirdAppIdConfigModel: Mappable {
    var appId: String = ""

    init() {

    }
    init(appId: String) {
        self.appId = appId
    }
    /// 通过ObjectMapper加载
    init?(map: Map) {

    }
    mutating func mapping(map: Map) {
        appId <- map["appId"]
    }
}

/// 仅含AppKey的三方配置
struct ThirdAppKeyConfigModel: Mappable {
    var appKey: String = ""

    init() {

    }
    init(appKey: String) {
        self.appKey = appKey
    }
    /// 通过ObjectMapper加载
    init?(map: Map) {

    }
    mutating func mapping(map: Map) {
        appKey <- map["appKey"]
    }
}

/// 通用的三方配置：含有appId 和 appKey，可兼容只有一个的情况(即上面的ThirdAppIdConfigModel、ThirdAppKeyConfigModel)
struct ThirdCommonConfigModel: Mappable {
    var appId: String = ""
    var appKey: String = ""

    init() {

    }
    init(appId: String, appKey: String) {
        self.appId = appId
        self.appKey = appKey
    }
    /// 通过ObjectMapper加载
    init?(map: Map) {

    }
    mutating func mapping(map: Map) {
        appId <- map["appId"]
        appKey <- map["appKey"]
    }
}

/// 微信配置: 含有appId/appKey/univeralLink
struct WechatConfigModel: Mappable {
    var appId: String = ""
    var appKey: String = ""
    var universalLink: String = ""

    init() {

    }
    init(appId: String, appKey: String, universalLink: String) {
        self.appId = appId
        self.appKey = appKey
        self.universalLink = universalLink
    }
    /// 通过ObjectMapper加载
    init?(map: Map) {

    }
    mutating func mapping(map: Map) {
        appId <- map["appId"]
        appKey <- map["appKey"]
        universalLink <- map["universalLink"]
    }
}

/// 新浪微博: 含有appId/appKey/redirectURL
struct SinaWeiboConfigModel: Mappable {
    var appId: String = ""
    var appKey: String = ""
    var redirectURL: String = ""

    init() {

    }
    init(appId: String, appKey: String, redirectURL: String) {
        self.appId = appId
        self.appKey = appKey
        self.redirectURL = redirectURL
    }
    /// 通过ObjectMapper加载
    init?(map: Map) {

    }
    mutating func mapping(map: Map) {
        appId <- map["appId"]
        appKey <- map["appKey"]
        redirectURL <- map["redirectURL"]
    }
}

/// 腾讯防水墙 TCWebCode
struct TCCaptchaConfigModel: Mappable {
    /// 密码登录
    var pwdLoginId: String = ""
    /// 短信登录
    var smsLoginId: String = ""
    /// 注册
    var registerId: String = ""
    /// 密码相关(除密码登录): 登录密码重置、支付密码初始化、支付密码重置、
    var passwordId: String = ""
    /// 换绑手机号
    var phoneBindId: String = ""

    init() {

    }
    /// 通过ObjectMapper加载
    init?(map: Map) {

    }
    mutating func mapping(map: Map) {
        pwdLoginId <- map["pwdLoginId"]
        smsLoginId <- map["smsLoginId"]
        registerId <- map["registerId"]
        passwordId <- map["passwordId"]
        phoneBindId <- map["phoneBindId"]
    }
}

/// 环信
struct EaseMobConfigModel: Mappable {
    /// key
    var appKey: String = ""
    /// 证书名称 用于推送
    var certName: String = ""

    init() {

    }
    init(appKey: String, certName: String) {
        self.appKey = appKey
        self.certName = certName
    }
    /// 通过ObjectMapper加载
    init?(map: Map) {

    }
    mutating func mapping(map: Map) {
        appKey <- map["appKey"]
        certName <- map["certName"]
    }
}

/// 有赞
struct YouZanConfigModel: Mappable {
    /// cliendId
    var cliendId: String = ""
    /// kdtId
    var kdtId: String = ""

    init() {

    }
    init(cliendId: String, kdtId: String) {
        self.cliendId = cliendId
        self.kdtId = kdtId
    }
    /// 通过ObjectMapper加载
    init?(map: Map) {

    }
    mutating func mapping(map: Map) {
        cliendId <- map["cliendId"]
        kdtId <- map["kdtId"]
    }
}
