//
//  SearchHistoryModel.swift
//  BaseProject
//
//  Created by 小唐 on 2019/6/19.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  搜索历史记录数据模型

import Foundation

/// 搜索历史记录类型
enum SearchHistoryType: String {
    case none = "none"
    /// 动态
    case moment = "moment"
    /// 动态话题
    case momentTag = "momentTag"
}


/// 搜索历史记录数据模型
class SearchHistoryModel {

    var id: Int = 0

    var title: String = ""
    var typeValue: String = ""
    var createDate: Date = Date()
    var updateDate: Date = Date()

    var type: SearchHistoryType {
        var type: SearchHistoryType = SearchHistoryType.none
        if let realType = SearchHistoryType.init(rawValue: self.typeValue) {
            type = realType
        }
        return type
    }

    init(title: String, type: SearchHistoryType) {
        self.title = title
        self.typeValue = type.rawValue
    }


//    // DB
//    init(object: SearchHistoryObject) {
//        self.id = object.id
//        self.title = object.title
//        self.typeValue = object.typeValue
//        self.createDate = object.createDate
//        self.updateDate = object.updateDate
//    }
//    func object() -> SearchHistoryObject {
//        let object = SearchHistoryObject()
//        object.id = self.id
//        object.title = self.title
//        object.typeValue = self.typeValue
//        object.createDate = self.createDate
//        object.updateDate = self.updateDate
//        return object
//    }


}
