//
//  AdvertObject.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/13.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  广告的数据库模型

import Foundation
import RealmSwift

/// 广告位的数据库模型
class AdvertObject: Object {

    /// 广告标题
    @objc dynamic var title: String = ""
    /// 广告图片链接
    @objc dynamic var image: String = ""
    /// 广告响应跳转地址
    @objc dynamic var link: String = ""
    /// 跳转类型：0-静态广告仅做展示 1-外部则url字段为一个网页连接地址使用webview进行加载 2-内部连接 根绝规定进行跳转
    @objc dynamic var link_type: Int = 0
    /// 广告展示时间：单位秒,0-无限制
    @objc dynamic var time: Int = 0
    /// 广告位id
    @objc dynamic var spaceId: Int = 0
    /// 广告位标记
    @objc dynamic var spaceFlag: String = ""

    /// 设置主键
    override static func primaryKey() -> String? {
        return nil
    }
    /// 设置索引
    override static func indexedProperties() -> [String] {
        return []
    }
}
