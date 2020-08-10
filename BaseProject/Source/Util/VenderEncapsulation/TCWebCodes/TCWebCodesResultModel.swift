//
//  TCWebCodesResultModel.swift
//  TokenBook
//
//  Created by 小唐 on 2018/8/28.
//  Copyright © 2018 ZhiYiCX. All rights reserved.
//
//  TCWebCodes的扩展
//  TCWebCodes 验证结果的数据模型

import Foundation
import ObjectMapper

typealias TCWebCodesVerifyResultModel = TCWebCodesResultModel
class TCWebCodesResultModel: Mappable {

    /// 成功为0，其余为失败
    var code: Int = -1
    var appId: String = ""
    var ticket: String = ""
    var randStr: String = ""

    required init?(map: Map) {

    }
    func mapping(map: Map) {
        code <- map["ret"]
        appId <- map["appid"]
        ticket <- map["ticket"]
        randStr <- map["randstr"]
    }

}
