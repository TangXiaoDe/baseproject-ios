//
//  String+URL.swift
//  BaseProject
//
//  Created by 小唐 on 2019/7/8.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  String的URL相关扩展

import Foundation

extension String {

    /// url协议处理，有则不予处理，没有则添加
    func urlSchemeProcess(scheme: String = "http") -> String {
        var newUrl: String = self
        if self.hasPrefix("http://") || self.hasPrefix("https://") {
            return newUrl
        } else {
            newUrl = String.init(format: "%@://%@", scheme, newUrl)
        }
        return newUrl
    }
    static func urlSchemeProcess(url strUrl: String, scheme: String = "http") -> String {
        return strUrl.urlSchemeProcess(scheme: scheme)
    }

    /// url编码处理
    func urlCode() -> String {
        if let result = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            return result
        } else {
            return self
        }
    }
    static func urlCode(url strUrl: String) -> String {
        return strUrl.urlCode()
    }

}

extension String {

    func isMatchURL() -> Bool {
        var urlFlag: Bool = false
        if self.isEmpty {
            return urlFlag
        }
        let urlReger: String = "((http[s]{0,1}|ftp)://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"
        urlFlag = self.isMatchRegex(urlReger)
        return urlFlag
    }

}
