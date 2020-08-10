//
//  NoviceGuideModel.swift
//  BaseProject
//
//  Created by 小唐 on 2019/7/27.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  新手引导数据模型

import Foundation


/// 新手引导项目
enum NoviceGuideType {
    /// 一键挖矿使用
    case digOreAllUse
    /// 一键挖矿充值
    case digOreAllRecharge
    /// 好友分组
    case friendGuide
    /// 注册完善资料
    case registerCompleteInfo
    /// 个人中心
    case userCenter
    /// 挖矿入口更新
    case miningEntranceUpdate

    /// UserDefaults里存取的标志
    var identifier: String {
        let identifier: String
        switch self {
        case .digOreAllUse:
            identifier = "app.identifier.digOreAllUse"
        case .digOreAllRecharge:
            identifier = "app.identifier.digOreAllRecharge"
        case .friendGuide:
            identifier = "app.identifier.friendGuide"
        case .registerCompleteInfo:
            identifier = "app.identifier.registerCompleteInfo"
        case .userCenter:
            identifier = "app.identifier.userCenter"
        case .miningEntranceUpdate:
            identifier = "app.identifier.miningEntranceUpdate"
        }
        return identifier
    }

}

/// 新手引导具体选项数据模型
class NoviceGuideItemModel {
    var type: NoviceGuideType
    var complete: Bool = true

    init(type: NoviceGuideType, complete: Bool = true) {
        self.type = type
        self.complete = complete
    }
}


/// 新手引导数据模型
class NoviceGuideModel {
    /// 账号
    var account: String = ""
    /// 是否全部完成
    var isAllComplete: Bool = true
    /// 选项列表
    var items: [NoviceGuideItemModel] = []

    init(account: String, items: [NoviceGuideItemModel]) {
        self.account = account
        self.items = items
    }


}
