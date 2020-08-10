//
//  RecommendUserModel.swift
//  BaseProject
//
//  Created by 小唐 on 2019/7/16.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  推荐用户数据模型

import Foundation


/// 推荐用户类型
enum RecommendUserType: String {
    /// 标签推荐
    case tag = "tag"
    /// 大咖(社区之星)推荐
    case bigv = "dv"

    var navTitle: String {
        var title = ""
        switch self {
        case .tag:
            title = "推荐用户"
        case .bigv:
            //title = "推荐大咖"
            title = "社区之星"
        default:
            break
        }
        return title
    }

}


typealias RecommendUserModel = SimpleUserModel
