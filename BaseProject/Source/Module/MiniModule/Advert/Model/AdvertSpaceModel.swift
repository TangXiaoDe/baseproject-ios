//
//  AdvertSpaceModel.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/13.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  广告位数据模型

import Foundation
import ObjectMapper
import RealmSwift

/// 广告位类型
enum AdvertSpaceType: String {
    /// 启动页
    case boot = "app:start"
    /// APP-推荐广告
    case square = "app:plaza:top"
    /// APP-推荐广告
    case recommend = "app:recommend:top"
    /// 广场任务
    case squareTask = "app:plaza:task:top"
    /// 星球顶部广告
    case planet = "app:star:top"
}

class AdvertSpaceModel: Mappable {

    /// 广告位id
    var id: Int = 0
    /// 广告位标示
    var space: String = ""
    /// 广告位描述
    var alias: String = ""

    required init?(map: Map) {

    }
    func mapping(map: Map) {
        id <- map["id"]
        alias <- map["name"]
        space <- map["alias"]
    }

    // DB
    init(object: AdvertSpaceObject) {
        self.id = object.id
        self.space = object.space
        self.alias = object.alias
    }
    func object() -> AdvertSpaceObject {
        let object = AdvertSpaceObject()
        object.id = self.id
        object.space = self.space
        object.alias = self.alias
        return object
    }

}
