//
//  PhoneUtil.swift
//  BaseProject
//
//  Created by 小唐 on 2019/4/26.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  手机号码

import Foundation

/// 电话运行商类型
enum PhoneCarrierType: String {
    case none = ""
    case chain_mobile = "cmcc"
    case chain_unicom = "cucc"
    case chain_telecom = "ctcc"

    /// 匹配的正则表达式
    var regrex: String {
        var strRegex: String = ""
        switch self {
        case .chain_mobile:
            // 中国移动号码格式验证：134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
            strRegex = "(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)"
        // 中国联通号码格式验证 手机段：130,131,132,155,156,185,186,145,176,1709
        case .chain_unicom:
            strRegex = "(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)" + "|(^1709\\d{7}$)"
        case .chain_telecom:
            // 中国电信号码格式验证 手机段： 133,153,180,181,189,177,1700,173,199
            strRegex = "(^1(33|53|77|73|99|8[019])\\d{8}$)|" + "(^1700\\d{7}$)"
        case .none:
            strRegex = "1\\d{10}"
        }
        return strRegex
    }

    /// title
    var title: String {
        var title: String = ""
        switch self {
        case .chain_mobile:
            title = "中国移动"
        case .chain_unicom:
            title = "中国联通"
        case .chain_telecom:
            title = "中国电信"
        case .none:
            title = "未知运营商"
        }
        return title
    }

    /// 话费充值类型
    var billType: String {
        var type = ""
        switch self {
        case .chain_mobile:
            type = "cmcc-rate"
        case .chain_unicom:
            type = "cucc-rate"
        case .chain_telecom:
            type = "ctcc-rate"
        default:
            break
        }
        return type
    }

    /// 流量充值类型
    var flowType: String {
        var type = ""
        switch self {
        case .chain_mobile:
            type = "cmcc-traffic"
        case .chain_unicom:
            type = "cucc-traffic"
        case .chain_telecom:
            type = "ctcc-traffic"
        default:
            break
        }
        return type
    }

}

class PhoneUtil {
    class func isPhoneNum(_ phone: String) -> Bool {
        return phone.isPhoneNum()
    }

    /// 运行商判断
    class func getPhoneCarrier(_ phone: String) -> PhoneCarrierType {
        var type: PhoneCarrierType = PhoneCarrierType.none
        if phone.isMatchRegex(PhoneCarrierType.chain_mobile.regrex) {
            type = PhoneCarrierType.chain_mobile
        } else if phone.isMatchRegex(PhoneCarrierType.chain_unicom.regrex) {
            type = PhoneCarrierType.chain_unicom
        } else if phone.isMatchRegex(PhoneCarrierType.chain_telecom.regrex) {
            type = PhoneCarrierType.chain_telecom
        }
        return type
    }

}
