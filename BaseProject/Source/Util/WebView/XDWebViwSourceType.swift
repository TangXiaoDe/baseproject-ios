//
//  XDWebViwSourceType.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/22.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import Foundation

// 网页资源类型
enum XDWebViwSourceType {
    case url(url: URL)
    case strUrl(strUrl: String)
    case none
    case local(filePath: String)
    case content(html: String)
}
