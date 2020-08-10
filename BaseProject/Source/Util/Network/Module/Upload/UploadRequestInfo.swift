//
//  UploadRequestInfo.swift
//  BaseProject
//
//  Created by zhaowei on 2019/6/15.
//  Copyright © 2019 ChainOne. All rights reserved.
//  上传相关请求信息

import Foundation
/// 上传相关请求信息
class UploadRequestInfo {
    /// 上传凭证
    static let uploadToken = RequestInfo<UploadTokenModel>.init(method: .get, path: "upload/token", replaceds: [])

}
