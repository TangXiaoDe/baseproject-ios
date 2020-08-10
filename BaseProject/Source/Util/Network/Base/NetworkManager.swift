//
//  NetworkManager.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2019/1/14.
//  Copyright © 2019 TangXiaoDe. All rights reserved.
//
//  请求封装

import Foundation
import ObjectMapper
import Alamofire

/// 服务器扩展通知
extension Notification.Name {
    public struct Network {
        /// 登录授权不合法
        public static let Illicit = NSNotification.Name(rawValue: "notification.name.network.Illicit")
        /// 服务器停机维护
        public static let HostDown = NSNotification.Name(rawValue: "notification.name.network.HostDown")
    }
}

/// 特殊的状态码
enum StatusCode: Int {
    /// 登录授权不合法
    case illicit = 401
    /// 服务器停机维护
    case hostDown = 503
    /// 请求成功
    case requestSuccess = 200
}

class NetworkManager {
    static let share = NetworkManager()
    private init() {

    }

    /// 是否显示日志
    var isShowLog: Bool = false

    /// 跟路径
    fileprivate var rootURL: String?
    /// 超时时间
    fileprivate let requestTimeoutInterval = 60
    /// 授权-token
    fileprivate var authorization: String?

    /// Alamofire中的请求管理
    lazy var alamofireManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(self.requestTimeoutInterval)
        return Alamofire.SessionManager(configuration: configuration)
    }()

}

// MARK: - Public Function
extension NetworkManager {
    /// 设置请求的根地址
    ///
    /// - Parameter rootURL: 根地址字符串
    /// - Note: 设置后会导致所有的请求都依照该地址发起
    public func configRootURL(rootURL: String?) {
        self.rootURL = rootURL
    }

    /// 配置请求的授权口令
    ///
    /// - Parameter authorization: 授权token
    /// - Note: 配置后，每次请求的都会携带该参数
    public func configAuthorization(_ authorization: String?) {
        self.authorization = authorization
    }

    /// 文本请求
    ///
    /// - Parameters:
    ///   - request: 请求信息
    ///   - complete: 响应数据
    /// - Note: 当响应数据出现所有内容为空的情况,需要根据 statusCode 来自行决定显示的 message, 后台建议 500以上显示服务器错误,500以下显示网络错误
    /// - Note: 为什么参数只能命名为request，否则报错
    @discardableResult
    public func request<T: RequestInfoProtocol>(requestInfo: T, complete: @escaping (_ result: RequestResult<T>) -> Void) -> DataRequest {
        let result = self.requestInfoProcess(requestInfo, self.authorization)
        if self.isShowLog {
            self.showRequestLog(requestInfo, headers: result.headers, path: result.path)
        }
        return alamofireManager.request(result.path, method: requestInfo.method, parameters: requestInfo.parameter, encoding: result.encoding, headers: result.headers).responseJSON {  [unowned self] response in
            // 日志
            if self.isShowLog == true {
                print("http respond info \(response)")
            }
            // 错误处理
            guard response.result.isSuccess, let responseData = response.response else {
                // TODO: - 5xx服务器异常时可在这里通过error.code判断处理
                if let error: NSError = response.result.error as NSError?, error.domain == NSURLErrorDomain && error.code == NSURLErrorTimedOut {
                    let error = RequestError.timeout
                    let result = RequestResult<T>.error(error)
                    complete(result)
                } else {
                    let error = RequestError.failing
                    let result = RequestResult<T>.error(error)
                    complete(result)
                }
                return
            }
            // Token更新
            if let token = responseData.allHeaderFields["Authorization"] as? String, let accountInfo = AccountManager.share.currentAccountInfo {
                NetworkManager.share.configAuthorization(token)
                AccountManager.share.updateCurrentAccount(token: AccountTokenModel.init(account: accountInfo.account, token: token))
            }
            // 请求处理
            DispatchQueue.main.async(execute: {
                let result = response.result
                let statusCode = responseData.statusCode

                var resultModel: RequestResultModel<T>
                if let model = Mapper<RequestResultModel<T>>().map(JSONObject: result.value) {
                    resultModel = model
                } else {
                    resultModel = RequestResultModel<T>.init()
                }
                resultModel.statusCode = statusCode
                resultModel.sourceData = result.value

                /// 特殊状态码处理
                switch statusCode {
                case StatusCode.requestSuccess.rawValue:
                    // 200 - 请求成功
                    if let _ = Mapper<RequestResultModel<T>>().map(JSONObject: result.value) {
                        if resultModel.code == 0 {
                            let result = RequestResult<T>.success(resultModel)
                            complete(result)
                        } else if resultModel.code == 401 {
                            let result = RequestResult<T>.failure(resultModel)
                            complete(result)
                            NotificationCenter.default.post(name: NSNotification.Name.Network.Illicit, object: nil)
                        } else {
                            let result = RequestResult<T>.failure(resultModel)
                            complete(result)
                        }
                    } else {
                        let result = RequestResult<T>.failure(resultModel)
                        complete(result)
                    }
                case StatusCode.illicit.rawValue:
                    // 401 - Token过期
                    let result = RequestResult<T>.failure(resultModel)
                    complete(result)
                    NotificationCenter.default.post(name: NSNotification.Name.Network.Illicit, object: nil)
                case StatusCode.hostDown.rawValue:
                    // 503 - 服务器异常
                    let result = RequestResult<T>.failure(resultModel)
                    complete(result)
                    NotificationCenter.default.post(name: NSNotification.Name.Network.HostDown, object: nil)
                default:
                    let result = RequestResult<T>.failure(resultModel)
                    complete(result)
                }
                return
            })
        }

    }
}

// MARK: - Private Function
extension NetworkManager {
    /// 请求信息预处理
    /// - Note：存在rootURL时
    fileprivate func requestInfoProcess<T: RequestInfoProtocol>(_ requestInfo: T, _ authorization: String?) -> (headers: HTTPHeaders, path: String, encoding: ParameterEncoding) {
        guard let rootURL = self.rootURL else {
            fatalError("Network request data error uninitialized, unallocate authorization.")
        }
        let requestPath = rootURL + requestInfo.urlPath
        var coustomHeaders: HTTPHeaders = ["Accept": "application/json"]
        if let authorization = self.authorization {
            let token = "Bearer " + authorization
            coustomHeaders.updateValue(token, forKey: "Authorization")
        }

        let encoding: ParameterEncoding = (requestInfo.method == .get ? URLEncoding.default : JSONEncoding.default)

        return (headers: coustomHeaders, path: requestPath, encoding: encoding)
    }

    /// 显示请求日志
    fileprivate func showRequestLog<T: RequestInfoProtocol>(_ requestInfo: T, headers: HTTPHeaders, path: String) -> Void {
        var strRequestInfo: String = ""
        strRequestInfo += "\nRootURL: " + path
        strRequestInfo += "\nAuthorization: " + (headers["Authorization"] ?? "nil")
        strRequestInfo += "\nRequestMethod: " + requestInfo.method.rawValue
        strRequestInfo += "\nParameters: " + String(describing: requestInfo.parameter)
        strRequestInfo += "\n"
        print(strRequestInfo)
    }
}
