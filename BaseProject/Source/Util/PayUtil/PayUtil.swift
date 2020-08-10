//
//  PayUtil.swift
//  BaseProject
//
//  Created by 小唐 on 2019/4/29.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  支付工具

import Foundation

class PayUtil {

    /// 支付宝支付结果处理
    class func alipayResultProcess(_ result: [String: Any]?) -> Void {
        guard let result = result, let code = result["resultStatus"] as? String else {
            return
        }
        let message = PayUtil.alipayMessageWithResultCode(code)
        DispatchQueue.main.async {
            Toast.showToast(title: message)
            // 发送支付宝支付成功的通知
            NotificationCenter.default.post(name: Notification.Name.Pay.alipaySuccess, object: result)
        }
    }

    /// 支付宝支付结果码处理
    /// 建议 8000 和 6004，单独请求自己的服务器
    class func alipayMessageWithResultCode(_ code: String) -> String {
        var message: String = ""
        switch code {
        case "9000":
            // 9000 订单支付成功
            message = "支付成功"
        case "8000":
            // 8000 正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
            message = "正在处理中"
        case "4000":
            // 4000 订单支付失败
            message = "支付失败"
        case "5000":
            // 5000 重复请求
            message = "支付失败，重复请求"
        case "6001":
            // 6001 用户中途取消
            message = "支付失败，中途取消"
        case "6002":
            // 6002 网络连接出错
            message = "网络连接出错"
        case "6004":
            // 6004 支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
            message = "支付结果未知"
        default:
            // 其它支付错误
            message = "支付失败"
        }
        return message
    }

    /// 微信支付结果码处理

}
