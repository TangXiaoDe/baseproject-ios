//
//  ServerAddressConfig.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2018/11/29.
//  Copyright © 2018 TangXiaoDe. All rights reserved.
//
//  服务器配置

import Foundation

struct ServerAddressConfig {
    /// 服务器地址
    var address: String = ""
    /// 接口版本 api/v2/ —— 单独的接口请求中可配置接口对应的版本
    /// 端口

    //static let develop: ServerAddressConfig = ServerAddressConfig(address: "http://a.imeet.io/")
    static let develop: ServerAddressConfig = ServerAddressConfig(address: "https://a.imeet.io/")
    static let release: ServerAddressConfig = ServerAddressConfig(address: "https://www.immeet.com/")

    init(address: String) {
        self.address = address
    }

}
