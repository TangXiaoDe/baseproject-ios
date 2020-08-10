//
//  ServerVesionModel.swift
//  BaseProject
//
//  Created by 小唐 on 2019/3/20.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  服务器版本数据模型

import Foundation
import ObjectMapper

/// 服务器版本数据模型
class ServerVesionModel: Mappable {

    var id: Int = 0
    var type: String = ""
    /// 版本号 后台填写的版本
    var version: String = ""
    /// build号 版本号，客户端对比该数字进行版本更新
    var versionCode: Int = 0
    /// 更新说明
    var desc: String = ""
    /// 下载链接
    var link: String = UrlManager.signatureUpdateUrl
    /// 是否强制更新，0-非强制更新 1-强制更新
    var isForced: Bool = false
    var createDate: Date = Date()
    var updateDate: Date = Date()

    init() {

    }

    required init?(map: Map) {

    }
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        version <- map["version_name"]
        versionCode <- map["version_code"]
        desc <- map["description"]
        // 目前后台链接异常，需前端根据服务器来配置
        link <- map["link"]
        isForced <- map["is_forced"]
        createDate <- (map["created_at"], DateStringTransform.current)
        updateDate <- (map["updated_at"], DateStringTransform.current)
    }

}
