//
//  AccountNetworkManager.swift
//  BaseProject
//
//  Created by 小唐 on 2019/6/5.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  账号模块相关的网络请求

import Foundation

class AccountNetworkManager {

}

/// 验证码无需授权的场景
enum SMSCodeUnAuthScene: String {
    /// 短信登录
    case smscodeLogin = "app-code-login"
    /// 注册
    case register = "app-register"
    /// 登录密码忘记/重置
    case loginPwdForget = "app-login-pass"
    /// 绑定手机号 - 新手机号
    case phoneBind = "app-bind-phone"
}

/// 验证码需授权的场景
enum SMSCodeAuthScene: String {
    /// 支付密码
    case payPwd = "app-pay-pass"
    /// 绑定手机号 - 原手机号
    case phoneBind = "app-bind-phone"
}


// MARK: - Login
extension AccountNetworkManager {
    /// 密码登录
    class func pwdLogin(account: String, password: String, ticket: String, randStr: String, complete: @escaping((_ status: Bool, _ msg: String?, _ model: AccountTokenModel?) -> Void)) -> Void {
        // 1.请求 url
        var requestInfo = AccountRequestInfo.login
        requestInfo.urlPath = requestInfo.fullPathWith(replacers: [])
        // 2.配置参数
        let parameter: [String: Any] = ["phone": account, "type": "pass", "password": password, "ticket": ticket, "randstr": randStr]
        requestInfo.parameter = parameter
        // 3.发起请求
        NetworkManager.share.request(requestInfo: requestInfo) { (networkResult) in
            switch networkResult {
            case .error(_):
                complete(false, "prompt.network.error".localized, nil)
            case .failure(let failure):
                complete(false, failure.message, nil)
            case .success(let response):
                complete(true, response.message, response.model)
            }
        }
    }
    /// 短信验证码登录
    class func smsCodeLogin(account: String, smsCode: String, complete: @escaping((_ status: Bool, _ msg: String?, _ model: AccountTokenModel?) -> Void)) -> Void {
        // 1.请求 url
        var requestInfo = AccountRequestInfo.login
        requestInfo.urlPath = requestInfo.fullPathWith(replacers: [])
        // 2.配置参数
        let parameter: [String: Any] = ["phone": account, "type": "code", "code": smsCode]
        requestInfo.parameter = parameter
        // 3.发起请求
        NetworkManager.share.request(requestInfo: requestInfo) { (networkResult) in
            switch networkResult {
            case .error(_):
                complete(false, "prompt.network.error".localized, nil)
            case .failure(let failure):
                complete(false, failure.message, nil)
            case .success(let response):
                complete(true, response.message, response.model)
            }
        }
    }

}
// MARK: - Login
extension AccountNetworkManager {
    /// 登出
    class func logout(complete: @escaping((_ status: Bool, _ msg: String?) -> Void)) -> Void {
        // 1.请求 url
        var requestInfo = AccountRequestInfo.logout
        requestInfo.urlPath = requestInfo.fullPathWith(replacers: [])
        // 2.配置参数
        // 3.发起请求
        NetworkManager.share.request(requestInfo: requestInfo) { (networkResult) in
            switch networkResult {
            case .error(_):
                complete(false, "prompt.network.error".localized)
            case .failure(let failure):
                complete(false, failure.message)
            case .success(let response):
                complete(true, response.message)
            }
        }
    }

}

// MARK: - Register
extension AccountNetworkManager {
    /// 注册
    class func register(account: String, password: String, confirmPwd: String, smsCode: String, inviteCode: String?, complete: @escaping((_ status: Bool, _ msg: String?, _ data: (syncStatus: Bool, token: AccountTokenModel)?) -> Void)) -> Void {
        // 1.请求 url
        var requestInfo = AccountRequestInfo.register
        requestInfo.urlPath = requestInfo.fullPathWith(replacers: [])
        // 2.配置参数
        var parameter: [String: Any] = ["phone": account, "password": password, "password_confirmation": confirmPwd, "code": smsCode]
        if let inviteCode = inviteCode {
            parameter["invite_code"] = inviteCode
        }
        requestInfo.parameter = parameter
        // 3.发起请求
        NetworkManager.share.request(requestInfo: requestInfo) { (networkResult) in
            switch networkResult {
            case .error(_):
                complete(false, "prompt.network.error".localized, nil)
            case .failure(let failure):
                complete(false, failure.message, nil)
            case .success(let response):
                if let model = response.model {
                    // 兼容下未返该字段的情景
                    if let dicInfo = response.data as? [String: Any], let syncStatus = dicInfo["sync_status"] as? Bool {
                        let data = (syncStatus: syncStatus, token: model)
                        complete(true, response.message, data)
                    } else {
                        let data = (syncStatus: false, token: model)
                        complete(true, response.message, data)
                    }
                } else {
                    complete(true, response.message, nil)
                }
            }
        }
    }
}

extension AccountNetworkManager {

    /// 换绑手机号
    /// 备注：换绑成功，旧token会失效，需重新登录
    class func updateBindPhone(oriCode originalPhoneCode: String, newPhone: String, newCode newPhoneCode: String, complete: @escaping((_ status: Bool, _ msg: String?) -> Void)) -> Void {
        // 1.请求 url
        var requestInfo = AccountRequestInfo.updateBindPhone
        requestInfo.urlPath = requestInfo.fullPathWith(replacers: [])
        // 2.配置参数
        let parameter: [String: Any] = ["ori_code": originalPhoneCode, "phone": newPhone, "new_code": newPhoneCode]
        requestInfo.parameter = parameter
        // 3.发起请求
        NetworkManager.share.request(requestInfo: requestInfo) { (networkResult) in
            switch networkResult {
            case .error(_):
                complete(false, "prompt.network.error".localized)
            case .failure(let failure):
                complete(false, failure.message)
            case .success(let response):
                complete(true, response.message)
            }
        }
    }

}

// MARK: - SMSCode
extension AccountNetworkManager {
    /// 发送无需登录授权验证码 - 需账号
    class func sendUnAuthSMSCode(account: String, scene: SMSCodeUnAuthScene, ticket: String, randStr: String, complete: @escaping((_ status: Bool, _ msg: String?) -> Void)) -> Void {
        // 1.请求 url
        var requestInfo = AccountRequestInfo.SMSCode.send_unauth
        requestInfo.urlPath = requestInfo.fullPathWith(replacers: [])
        // 2.配置参数
        let parameter: [String: Any] = ["phone": account, "scene": scene.rawValue, "ticket": ticket, "randstr": randStr]
        requestInfo.parameter = parameter
        // 3.发起请求
        NetworkManager.share.request(requestInfo: requestInfo) { (networkResult) in
            switch networkResult {
            case .error(_):
                complete(false, "prompt.network.error".localized)
            case .failure(let failure):
                complete(false, failure.message)
            case .success(let response):
                complete(true, response.message)
            }
        }
    }
    /// 发送需登录授权验证码
    class func sendAuthSMSCode(scene: SMSCodeAuthScene, ticket: String, randStr: String, complete: @escaping((_ status: Bool, _ msg: String?) -> Void)) -> Void {
        // 1.请求 url
        var requestInfo = AccountRequestInfo.SMSCode.send_auth
        requestInfo.urlPath = requestInfo.fullPathWith(replacers: [])
        // 2.配置参数
        let parameter: [String: Any] = ["scene": scene.rawValue, "ticket": ticket, "randstr": randStr]
        requestInfo.parameter = parameter
        // 3.发起请求
        NetworkManager.share.request(requestInfo: requestInfo) { (networkResult) in
            switch networkResult {
            case .error(_):
                complete(false, "prompt.network.error".localized)
            case .failure(let failure):
                complete(false, failure.message)
            case .success(let response):
                complete(true, response.message)
            }
        }
    }

    /// 验证码校验 - 无需认证登录
    class func verifyUnAuthSMSCode(account: String, scene: SMSCodeUnAuthScene, code: String, complete: @escaping((_ status: Bool, _ msg: String?) -> Void)) -> Void {
        // 1.请求 url
        var requestInfo = AccountRequestInfo.SMSCode.verify_unauth
        requestInfo.urlPath = requestInfo.fullPathWith(replacers: [])
        // 2.配置参数
        let parameter: [String: Any] = ["phone": account, "scene": scene.rawValue, "code": code]
        requestInfo.parameter = parameter
        // 3.发起请求
        NetworkManager.share.request(requestInfo: requestInfo) { (networkResult) in
            switch networkResult {
            case .error(_):
                complete(false, "prompt.network.error".localized)
            case .failure(let failure):
                complete(false, failure.message)
            case .success(let response):
                complete(true, response.message)
            }
        }
    }

    /// 验证码校验 - 需认证登录
    class func verifyAuthSMSCode(scene: SMSCodeAuthScene, code: String, complete: @escaping((_ status: Bool, _ msg: String?) -> Void)) -> Void {
        // 1.请求 url
        var requestInfo = AccountRequestInfo.SMSCode.verify_auth
        requestInfo.urlPath = requestInfo.fullPathWith(replacers: [])
        // 2.配置参数
        let parameter: [String: Any] = ["scene": scene.rawValue, "code": code]
        requestInfo.parameter = parameter
        // 3.发起请求
        NetworkManager.share.request(requestInfo: requestInfo) { (networkResult) in
            switch networkResult {
            case .error(_):
                complete(false, "prompt.network.error".localized)
            case .failure(let failure):
                complete(false, failure.message)
            case .success(let response):
                complete(true, response.message)
            }
        }
    }

}
