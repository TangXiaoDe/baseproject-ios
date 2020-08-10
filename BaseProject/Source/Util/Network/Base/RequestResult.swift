//
//  RequestResult.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2019/1/14.
//  Copyright © 2019 TangXiaoDe. All rights reserved.
//
//  请求结果封装

import Foundation
import Alamofire
import ObjectMapper

/// 网络请求结果
///
/// - success: 响应成功,返回数据
/// - failure: 响应序列化错误,返回失败原因
/// - error: 请求错误
public enum RequestResult<T: RequestInfoProtocol> {
    case success(RequestResultModel<T>)
    case failure(RequestResultModel<T>)
    case error(RequestError)
}

/// 正常情况下的响应类型
public struct RequestResultModel<T: RequestInfoProtocol>: Mappable {

    /// 响应code
    public var code: Int = -1
    /// 响应message
    public var message: String? = nil
    /// 解析的数据模型
    public var model: T.ResponseModel? = nil
    /// 解析的数据模型列表
    public var models: [T.ResponseModel] = []
    /// 数据
    public var data: Any? = nil

    /// 状态码
    public var statusCode: Int = 0
    /// 源数据，整个请求的返回结果
    public var sourceData: Any? = nil

    init() {

    }

    public init?(map: Map) {
    }
    public mutating func mapping(map: Map) {
        code <- map["code"]
        message <- map["msg"] // message
        model <- map["data"]
        models <- map["data"]
        data <- map["data"]
    }

}

/// 空类型 返回数据源无需解析时使用
///
/// - Note: 设置 RequestInfo.ResponseModel 为该类型表示不需要解析 ResponseModel
public struct Empty: Mappable {
    public init?(map: Map) {
    }
    public func mapping(map: Map) {
    }
}

/// 请求错误时的类型
public enum RequestError: String {
    /// 网络请求超时
    case timeout = "network.error.timeout"
    /// 网络请求错误（非超时以外的一切错误都会抛出该值，具体错误信息会输出到控制台）
    case failing = "network.error.failing"
}
