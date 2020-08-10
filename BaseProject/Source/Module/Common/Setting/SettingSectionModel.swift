//
//  SettingSectionModel.swift
//  BaseProject
//
//  Created by 小唐 on 2019/6/25.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  设置分组数据模型

import Foundation

/// 设置分组数据模型
class SettingSectionModel {

    var title: String? = nil
    var items: [SettingItemModel] = []

    init(title: String? = nil, items: [SettingItemModel] = []) {
        self.title = title
        self.items = items
    }

}
