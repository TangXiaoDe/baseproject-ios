//
//  UploadNetworkManager.swift
//  BaseProject
//
//  Created by zhaowei on 2019/6/15.
//  Copyright © 2019 ChainOne. All rights reserved.
//  上传token请求接口

import Foundation

/// 上传token请求接口
class UploadNetworkManager {
    /// uploadtoken
    class func getUploadToken(complete: @escaping((_ status: Bool, _ msg: String?, _ model: UploadTokenModel?) -> Void)) -> Void {
        // 1.请求 url
        var requestInfo = UploadRequestInfo.uploadToken
        requestInfo.urlPath = requestInfo.fullPathWith(replacers: [])
        // 2.配置参数
        // 3.发起请求
        NetworkManager.share.request(requestInfo: requestInfo) { (networkResult) in
            switch networkResult {
            case .error(_):
                complete(false, "prompt.network.error".localized, nil)
            case .failure(let failure):
                complete(false, failure.message, nil)
            case .success(let response):
                complete(true, response.message, response.model)
            }
        }
    }

}

// 文件上传
extension UploadNetworkManager {

}
