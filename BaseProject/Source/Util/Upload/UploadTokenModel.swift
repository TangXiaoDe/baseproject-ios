//
//  UploadTokenModel.swift
//  BaseProject
//
//  Created by zhaowei on 2019/6/15.
//  Copyright © 2019 ChainOne. All rights reserved.
//  上传凭证模型

import Foundation
import ObjectMapper

class UploadTokenModel: Mappable {

    var uploadToken: String = ""

    required init?(map: Map) {

    }
    func mapping(map: Map) {
        uploadToken <- map["token"]
    }
}
