//
//  RequestResultCode.swift
//  BaseProject
//
//  Created by 小唐 on 2019/3/1.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  业务码
//  业务码与状态码的区别：
//  业务码: 4022-参数错误 4033-请求不被允许 5000-服务端 1000-未设置支付密码 1001-支付密码错误 1002-未通过认证 1003-一键挖矿特权到期 4001-请求繁忙客户端无需处理

import Foundation

/// 业务码
typealias RequestCode = RequestResultCode
/// 业务码
enum RequestResultCode: Int {
    /// 成功
    case success = 0

    /// 未设置支付密码
    case payPwdUnIntial = 1000
    /// 支付密码错误
    case payPwdWrong = 1001
    /// 未认证/未通过认证
    case unCertified = 1002
    /// 一键收取服务到期
    case digAllExpire = 1003
    /// 只有社区创建者或社区管理员才能领取大厅任务
    case taskNoPermission = 1010
    /// 请求繁忙
    case requestBusy = 4001
    /// 参数错误
    case parameterError = 4022
    /// 请求不被允许
    case forbidden = 4033
    /// 服务端错误
    case serverError = 5000

    /// 请求对象不存在或已被删除，如：动态被删除、社群被解散等
    case notFound = 4404

}
