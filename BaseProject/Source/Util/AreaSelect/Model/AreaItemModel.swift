//
//  AreaItemModel.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2019/1/15.
//  Copyright © 2019 TangXiaoDe. All rights reserved.
//
//  地区节点模型 - 省市区模型

import Foundation

class AreaItemModel {
    var id: String
    var parentId: String
    var title: String
    var childs: [AreaItemModel] = []

    init(id: String, parentId: String, title: String) {
        self.id = id
        self.parentId = parentId
        self.title = title
    }

}
