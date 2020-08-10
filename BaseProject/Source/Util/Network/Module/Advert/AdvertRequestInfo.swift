//
//  AdvertRequestInfo.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/13.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  广告相关请求信息

import Foundation

class AdvertRequestInfo {
    /// 广告位
    static let spaces = RequestInfo<AdvertSpaceModel>.init(method: .get, path: "ad/pos", replaceds: [])
    /// 指定广告位下的广告
    static let spaceAdverts = RequestInfo<AdvertModel>.init(method: .get, path: "ad", replaceds: [])

}
