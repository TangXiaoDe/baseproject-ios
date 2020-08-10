//
//  PublishVideoModel.swift
//  BaseProject
//
//  Created by zhaowei on 2019/6/17.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import Foundation
import ObjectMapper

class PublishVideoModel: Mappable {
    var mime: String = "video/mp4"
    var filename: String = ""

    init() {
    }

    required init?(map: Map) {
    }

    // Mappable
    func mapping(map: Map) {
        mime <- map["mime"]
        filename <- map["filename"]
    }
}
