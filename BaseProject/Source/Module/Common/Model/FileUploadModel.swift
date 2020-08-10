//
//  FileUploadModel.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/22.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  文件上传的数据模型

import Foundation
import ObjectMapper

class FileUploadModel: Mappable {

    /// 文件id
    var id: Int = 0
    /// 文件名称
    var name: String = ""
    /// 文件链接
    var strUrl: String = ""

    init(id: Int = 0, name: String = "", strUrl: String = "") {
        self.id = id
        self.name = name
        self.strUrl = strUrl
    }

    required init?(map: Map) {

    }
    func mapping(map: Map) {
        id <- map["file_id"]
        name <- map["filename"]
        strUrl <- map["file_url"]
    }

}
