//
//  NetworkRequestInfo.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2019/1/14.
//  Copyright © 2019 TangXiaoDe. All rights reserved.
//
//  请求信息封装

import Foundation
import Alamofire
import ObjectMapper

/// 请求信息封装协议
public protocol RequestInfoProtocol {
    /// 网络请求路由，不包含跟地址
    var urlPath: String! { set get }
    /// 网络请求方式
    var method: HTTPMethod { set get }
    /// 网络请求参数
    var parameter: [String: Any]? { set get }
    /// 相关的响应数据模型
    ///
    /// - Note: 该模型需要实现相对应的解析协议
    associatedtype ResponseModel: Mappable
}

struct RequestInfo<T: Mappable>: RequestInfoProtocol {
    /// 网络请求路由，不包含跟地址
    var urlPath: String!
    /// 网络请求方式
    var method: HTTPMethod
    /// 网络请求参数
    var parameter: [String: Any]?
    /// 相关的响应数据模型
    ///
    /// - Note: 该模型需要实现相对应的解析协议
    typealias ResponseModel = T

    /// 版本路由
    let version: String
    /// 待替换路由
    let path: String
    /// 待替换关键字
    let replaceds: [String]

    /// 初始化
    ///
    /// - Parameters:
    ///   - version: 接口版本信息
    ///   - method: 接口请求方式
    ///   - path: 接口路径
    ///   - replacers: 接口路径替换关键字
    /// - Warning: replacers 需要避免传入相同的关键字,会导致替换错误
    init(version: String = URLPathManager.Version.v0, method: HTTPMethod, path: String, replaceds: [String]) {
        self.version = version
        self.method = method
        self.path = path
        self.replaceds = replaceds
    }

    /// 路由处理
    mutating func processPath(replacers: [String]) -> Void {
        if replacers.isEmpty || self.replaceds.isEmpty {
            self.urlPath = self.version + self.path
        }
        // [待办事项] 将路由用 / 进行拆分 然后比较替换
        var path = self.version + self.path
        for (index, replacer) in self.replaceds.enumerated() {
            path = path.replacingOccurrences(of: replacer, with: replacers[index])
        }
        self.urlPath = path
    }

    /// 替换拼接完整的路径
    ///
    /// - Parameter replacers: 替换的关键字
    /// - Returns: 完整的路径
    func fullPathWith(replacers: [String]) -> String {
        if replacers.isEmpty || self.replaceds.isEmpty {
            return self.version + self.path
        }
        // [待办事项] 将路由用 / 进行拆分 然后比较替换
        var path = self.version + self.path
        for (index, replacer) in self.replaceds.enumerated() {
            path = path.replacingOccurrences(of: replacer, with: replacers[index])
        }
        return path
    }
}
