//
//  DateFormatterManager.swift
//  BaseProject
//
//  Created by 小唐 on 2019/7/22.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  日期格式化管理

import Foundation

/// 格式化方案
enum TWFormatType {
    case tbbase
    case tbstring
    case tbweek
    case tbsimple
    case tbnormal
    case tbdetail
}

class TBDateFormatterManager {

    static let `default` = TBDateFormatterManager()
    private init() {
    }

    fileprivate var tbbase: TBBaseDateFormatter = TBBaseDateFormatter()
    fileprivate var tbstring: TBStringDateFormatter = TBStringDateFormatter.default
    fileprivate var tbweek: TBWeekDateFormatter = TBWeekDateFormatter.default
    fileprivate var tbsimple: TBSimpleDateFormatter = TBSimpleDateFormatter()
    fileprivate var tbnormal: TBNormalDateFormatter = TBNormalDateFormatter()
    fileprivate var tbdetail: TBDetailDateFormatter = TBDetailDateFormatter()

    /// 指定日期按照指定类型进行格式化
    func formatDate(_ date: Date, type: TWFormatType, timeZone: TimeZone? = TimeZone.current) -> String {
        var result: String = ""
        switch type {
        case .tbbase:
            result = self.tbbase.formatDate(date, timeZone: timeZone)
        case .tbstring:
            result = self.tbstring.formatDate(date, timeZone: timeZone)
        case .tbweek:
            result = self.tbweek.formatDate(date, timeZone: timeZone)
        case .tbsimple:
            result = self.tbsimple.formatDate(date, timeZone: timeZone)
        case .tbnormal:
            result = self.tbnormal.formatDate(date, timeZone: timeZone)
        case .tbdetail:
            result = self.tbdetail.formatDate(date, timeZone: timeZone)
        }
        return result
    }

}
