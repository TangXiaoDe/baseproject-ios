//
//  AppDelegate+WxApi.swift
//  BaseProject
//
//  Created by 小唐 on 2019/3/2.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  <WXApiDelegate>

import Foundation
import Alamofire

extension AppDelegate {
    func wechatHandleOpen(url: URL) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
}

extension AppDelegate: WXApiDelegate {
    func onReq(_ req: BaseReq) {
        print("请求类型:", req.type, "openID:", req.openID)
    }

    /// 回调响应
    func onResp(_ resp: BaseResp) {
        print("错误码:", resp.errCode, "错误提示字符串:", resp.errStr, "响应类型:", resp.type)
        var message: String = resp.errStr
        if let payResp = resp as? PayResp {
            // 支付处理
            switch payResp.errCode {
            case 0:
                // 成功
                //message = "支付成功"
                //Toast.showToast(title: "支付成功")
                CashPayManager.share.wxpaySuccessProcess()
                NotificationCenter.default.post(name: Notification.Name.Pay.wechatPaySuccess, object: payResp)
                return
            case -1:
                // 错误
                Toast.showToast(title: message)
                return
            case -2:
                // 用户取消
                message = "支付失败，用户取消"
                Toast.showToast(title: message)
                return
            default:
                break
            }
        } else if let authResp = resp as? SendAuthResp {
            // 授权处理
            switch authResp.errCode {
            case 0:
                // 成功
                if let code = authResp.code {
                    let appId = AppConfig.share.third.wechat.appId
                    let appSecret = AppConfig.share.third.wechat.appKey
                    self.getWechatInfo(appid: appId, secret: appSecret, code: code)
                    return
                }
            case -1:
                // 错误
                break
            case -2:
                // 用户取消
                message = "授权失败，用户取消"
                break
            default:
                break
            }
        } else {
            // 其他未知，不予处理
        }
    }

    /// 获取access_token、openid等信息
    fileprivate func getWechatInfo(appid: String, secret: String, code: String) -> Void {
        let url: String = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=\(appid)&secret=\(secret)&code=\(code)&grant_type=authorization_code"
        Alamofire.request(url).responseJSON { (response) in
            print(response.result)
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }

}
