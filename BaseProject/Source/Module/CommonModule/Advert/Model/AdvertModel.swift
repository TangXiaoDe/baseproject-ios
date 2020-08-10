//
//  AdvertModel.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/13.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  广告数据模型

import Foundation
import ObjectMapper
import RealmSwift

enum AdvertLinkType: Int {
    case none = 0
    case outside = 1
    case inside = 2
}

enum AdvertInLinkType: String {
    case none = ""
    case activity = "activity"
}

class AdvertModel: Mappable {
    /// 广告图片链接
    var image: String = ""
    /// 广告响应跳转地址,null-无跳转
    var link: String = ""
    /// 跳转类型:0-静态广告仅做展示 1-外部则url字段为一个网页连接地址使用webview进行加载 2-内部连接 根绝规定进行跳转
    var link_type: Int = 0
    /// 广告位标记，
    var adId: Int = 0

    var imageUrl: URL? {
        return UrlManager.fileUrl(name: self.image)
        //return URL.init(string: self.icon)
    }

    /// 暂时没用的
    /// 广告展示时间：单位秒,0-无限制
    var time: Int = 0
    var alreadyTime: Int = 0
    var duration: Int {
        var duration = 3
        if self.time > 0 && self.time < 10 {
            duration = self.time
        }
        return duration
    }

    /// 广告位id，[注]外界设置，网络请求结果中未返回
    var spaceId: Int = 0
    /// 广告位标记，
    var spaceFlag: String = ""

    var linkType: AdvertLinkType {
        var type: AdvertLinkType = AdvertLinkType.none
        if let linkType = AdvertLinkType.init(rawValue: self.link_type) {
            type = linkType
        }
        return type
    }
    /// 是否可跳过
    var canSkip: Bool = true
    
    
    /// 内链类型
    var inLinkType: AdvertInLinkType {
        var type: AdvertInLinkType = AdvertInLinkType.none
        var linkValue = self.link
        if let inLinkValue = linkValue.components(separatedBy: "|").first, let inLinkType = AdvertInLinkType.init(rawValue: inLinkValue) {
            type = inLinkType
        }
        return type
    }
    /// 内链id
    var inLinkId: Int? {
        var inLinkId: Int? = nil
        var linkValue = self.link
        if let idValue = linkValue.components(separatedBy: "|").last, let realInLinkId = Int(idValue) {
            inLinkId = realInLinkId
        }
        return inLinkId
    }

    required init?(map: Map) {

    }
    func mapping(map: Map) {
        adId <- map["id"]
        image <- map["image"]
        link <- map["url"]
        link_type <- map["url_type"]
    }

    // DB
    init(object: AdvertObject) {
        self.image = object.image
        self.link = object.link
        self.link_type = object.link_type
        self.spaceId = object.spaceId
        self.spaceFlag = object.spaceFlag
    }
    func object() -> AdvertObject {
        let object = AdvertObject()
        object.image = self.image
        object.link = self.link
        object.link_type = self.link_type
        object.spaceId = self.spaceId
        object.spaceFlag = self.spaceFlag
        return object
    }

}
