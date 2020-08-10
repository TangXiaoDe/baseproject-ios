//
//  AdverHelper.swift
//  BaseProject
//
//  Created by 小唐 on 2019/3/1.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  广告工具/广告助手

import Foundation

class AdverHelper {

    /// 从链接中识别商品id
    /// 格式: "goods|id"，范例："goods|5"
    class func recogniseProductFromLink(_ link: String) -> Int? {
        var id: Int? = nil
        if link.hasPrefix("goods|") {
            let strId = link.replacingOccurrences(of: "goods|", with: "")
            if let valueId = Int(strId) {
                id = valueId
            }
        }
        return id
    }

}
