//
//  AlipayResultModel.swift
//  BaseProject
//
//  Created by 小唐 on 2019/4/29.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  支付宝支付结果数据模型

import Foundation
import ObjectMapper

/// 支付宝支付响应数据模型
class AlipayResponseModel: Mappable {

    var status: Int = 0
    var memo: String = ""
    var result: AlipayResultModel? = nil

    required init?(map: Map) {

    }
    func mapping(map: Map) {
        status <- map["resultStatus"]
        memo <- map["memo"]
        result <- map["result"]
    }

}

/// 支付宝支付结果数据模型
class AlipayResultModel: Mappable {

    var sign: String? = ""
    var signType: String = ""
    var tradeResponse: AlipayAppTradeResponseModel? = nil

    required init?(map: Map) {

    }
    func mapping(map: Map) {
        sign <- map["sign"]
        signType <- map["sign_type"]
        tradeResponse <- map["alipay_trade_app_pay_response"]
    }

}

/// APP支付交易结果数据模型
class AlipayAppTradeResponseModel: Mappable {

    /// 结果码 https://docs.open.alipay.com/common/105806
    var code: String = ""
    /// 处理结果的描述，信息来自于code返回结果的描述
    var message: String = ""
    /// 支付宝分配给开发者的应用Id
    var appId: String = ""
    ///
    var authAppId: String = ""
    /// 编码格式
    var charset: String = ""
    /// 时间
    var timestamp: String = "" //  yyyy-mm-dd hh:mm:ss
    /// 商户网站唯一订单号
    var outTradeNo: String = ""
    /// 该笔订单的资金总额，单位为RMB-Yuan。取值范围为[0.01,100000000.00]，精确到小数点后两位。
    var totalAmount: String = ""
    /// 该交易在支付宝系统中的交易流水号。
    var tradeNo: String = ""
    /// 收款支付宝账号对应的支付宝唯一用户号。以2088开头的纯16位数字
    var sellerId: String = ""

    required init?(map: Map) {

    }
    func mapping(map: Map) {
        code <- map["code"]
        message <- map["msg"]
        appId <- map["app_id"]
        authAppId <- map["auth_app_id"]
        charset <- map["charset"]
        timestamp <- map["timestamp"]
        outTradeNo <- map["out_trade_no"]
        totalAmount <- map["total_amount"]
        tradeNo <- map["trade_no"]
        sellerId <- map["seller_id"]
    }
}
