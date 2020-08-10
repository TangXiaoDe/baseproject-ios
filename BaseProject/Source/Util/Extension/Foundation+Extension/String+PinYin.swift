//
//  String+PinYin.swift
//  BaseProject
//
//  Created by 小唐 on 2019/6/21.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  String的拼音扩展

import Foundation

extension String {


    /// String -> strPinYin
    func toPinYin() -> String {
        return String.pinYinString(from: self)
    }
    /// String -> strPinYin
    static func pinYinString(from string: String) -> String {
        // 1. 原字符串 -> 可变字符串
        let strMutable = NSMutableString.init(string: string)
        // 2. 中文 -> 带声调的拼音
        CFStringTransform(strMutable, nil, kCFStringTransformToLatin, false)
        // 3. 去掉声调
        let strPinYin = strMutable.folding(options: NSString.CompareOptions.diacriticInsensitive, locale: Locale.current)
        // 4. 多音字处理
        let strResult = String.polyphoneStringHandle(strPolyphone: string, strPinYin: strPinYin)
        return strResult
    }


    /// 拼音首字母(大写，不识别则为#)
    func pinYinFirstLetter() -> String {
        return String.pinYinFirstLetter(from: self)
    }
    /// 拼音首字母(大写，不识别则为#)
    static func pinYinFirstLetter(from string: String) -> String {
        // 1. -> pinyin
        let strPinYin = String.pinYinString(from: string)
        // 2. 大写
        let strUpper = strPinYin.uppercased()
        if strUpper.isEmpty {
            return "#"
        }
        // 3. 截取首字母
        let firstLetter = strUpper.subString(location: 0, length: 1)
        // 4. 判断首字母
        let strRegex: String = "^[A-Z]$"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", strRegex)
        return predicate.evaluate(with: firstLetter) ? firstLetter : "#"
    }


    /// 多音字处理，根据需要添自行加(polyphone 多音字)
    static func polyphoneStringHandle(strPolyphone: String, strPinYin: String) -> String {
        if strPolyphone.hasPrefix("长") {return "chang"}
        if strPolyphone.hasPrefix("沈") {return "shen"}
        if strPolyphone.hasPrefix("厦") {return "xia"}
        if strPolyphone.hasPrefix("地") {return "di"}
        if strPolyphone.hasPrefix("重") {return "chong"}
        return strPinYin
    }


}
