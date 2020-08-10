//
//  AccountRequestInfo.swift
//  BaseProject
//
//  Created by 小唐 on 2019/6/5.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  账号相关请求信息
//  登录、注册、注销、验证码、

import Foundation

class AccountRequestInfo {
    /// 登录
    static let login = RequestInfo<AccountTokenModel>.init(method: .post, path: "auth/login", replaceds: [])
    /// 注册
    static let register = RequestInfo<AccountTokenModel>.init(method: .post, path: "auth/register", replaceds: [])
    /// 注销
    static let logout = RequestInfo<Empty>.init(method: .post, path: "auth/logout", replaceds: [])
    /// 换绑手机号
    static let updateBindPhone = RequestInfo<Empty>.init(method: .patch, path: "binding/phone", replaceds: [])

    /// 验证码
    struct SMSCode {
        /// 验证码发送 - 无需认证登录
        static let send_unauth = RequestInfo<Empty>.init(method: .post, path: "verification-code", replaceds: [])
        /// 验证码发送 - 需认证登录
        static let send_auth = RequestInfo<Empty>.init(method: .post, path: "auth/verification-code", replaceds: [])
        /// 验证码校验 - 无需认证登录
        static let verify_unauth = RequestInfo<Empty>.init(method: .post, path: "verification-code/check", replaceds: [])
        /// 验证码校验 - 需认证登录
        static let verify_auth = RequestInfo<Empty>.init(method: .post, path: "verification-code/auth/check", replaceds: [])
    }


}
