//
//  DateFormatter.swift
//  BaseProject
//
//  Created by 小唐 on 2019/7/22.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  日期格式化

import Foundation

protocol TBDateFormatterProtocol {
    func formatDate(_ date: Date, timeZone: TimeZone?) -> String
}

class TBBaseDateFormatter: TBDateFormatterProtocol {
    let formatter: DateFormatter = DateFormatter()
    let calendar: Calendar = Calendar(identifier: .gregorian)

    func formatDate(_ date: Date, timeZone: TimeZone?) -> String {
        return date.string(format: "yyyy-MM-dd HH:mm:ss", timeZone: timeZone)
    }
}

/// 可直接格式化获取的
class TBStringDateFormatter: TBBaseDateFormatter {
    var normalFormat: String

    /// 默认构造，非单例
    static let `default` = TBStringDateFormatter(dateFormat: "yyyy-MM-dd HH:mm:ss")
    init(dateFormat: String) {
        self.normalFormat = dateFormat
    }

    override func formatDate(_ date: Date, timeZone: TimeZone?) -> String {
        formatter.dateFormat = normalFormat
        formatter.timeZone = timeZone
        let strDate = formatter.string(from: date)
        return strDate
    }
}

/// 星期的方式: 星期几 或 周几
/// 该方式其实可以通过TWNormalDateFormatter实现
class TBWeekDateFormatter: TBBaseDateFormatter {

    /// 星期的描述  EEEE为星期几，EEE为周几，e为数字
    let weekFormat: String

    /// 默认构造，非单例
    static let `default` = TBWeekDateFormatter(weekFormat: "EEE")
    init(weekFormat: String) {
        self.weekFormat = weekFormat
    }

    override func formatDate(_ date: Date, timeZone: TimeZone?) -> String {
        formatter.timeZone = timeZone
        formatter.dateFormat = "yyyy-MM-dd"
        let day = formatter.string(from: date)
        formatter.dateFormat = "HH:mm"
        let time = formatter.string(from: date)
        // EEEE为星期几，EEE为周几，e为数字
        formatter.dateFormat = self.weekFormat
        let week = formatter.string(from: date)
        let result: String = day + " " + week + " " + time
        return result
    }

}

/// tb自定义 仅显示日期，且1分钟内、1小时内、今天之内都没有进行特殊处理
class TBSimpleDateFormatter: TBBaseDateFormatter {
    /// simple 类型的时间
    /// - Note:
    /// 个人主页
    /// 1天内显示 今\n天，
    /// 1天到2天显示 昨\n天，
    /// 2天以上显示月日如 24\n12月、09\n2 月，当月份小于 10 时，数字和月份之间有个空格
    ///
    override func formatDate(_ date: Date, timeZone: TimeZone?) -> String {
        let now: Date = Date()
        let today = calendar.startOfDay(for: now)
        let yesterday = calendar.date(byAdding: Calendar.Component.day, value: -1, to: today, wrappingComponents: false)!
        let twoday = calendar.date(byAdding: Calendar.Component.day, value: -2, to: today, wrappingComponents: false)!
        //let nightday = calendar.date(byAdding: Calendar.Component.day, value: -9, to: today, wrappingComponents: false)!

        var result: String = ""
        formatter.timeZone = timeZone
        if date.isLate(than: today) {
            result = "今天"
        } else if date.isEarly(than: today) && date.isLate(than: yesterday) {
            result = "昨天"
        } else if date.isEarly(than: yesterday) && date.isLate(than: twoday) {
            result = "前天"
        } else {
            formatter.dateFormat = "MM-dd"
            result = formatter.string(from: date)
        }
        return result
    }
}
/// tb自定义 仅显示日期，但1分钟内、1小时内、今天之内都需要进行特殊处理
class TBNormalDateFormatter: TBBaseDateFormatter {

    /// - Note:
    /// 一分钟内显示一分钟内
    /// 一小时内显示几分钟前
    /// 一天内显示几小时前
    /// 1天到2天显示昨天
    /// 2天到3天显示前天
    /// 3天以上显示月日如（05-21）
    override func formatDate(_ date: Date, timeZone: TimeZone?) -> String {
        let now: Date = Date()
        let today = calendar.startOfDay(for: now)
        let oneMinute = calendar.date(byAdding: Calendar.Component.minute, value: -1, to: now, wrappingComponents: false)!
        let oneHour = calendar.date(byAdding: Calendar.Component.hour, value: -1, to: now, wrappingComponents: false)!
        let yesterday = calendar.date(byAdding: Calendar.Component.day, value: -1, to: today, wrappingComponents: false)!
        let twoday = calendar.date(byAdding: Calendar.Component.day, value: -2, to: today, wrappingComponents: false)!

        var result: String = ""
        let component = calendar.dateComponents([.day, .hour, .minute], from: date, to: now)
        formatter.timeZone = timeZone
        if date.isLate(than: oneMinute) {
            // 1min的判断不够严谨
            result = "1分钟内"
        } else if date.isEarly(than: oneMinute) && date.isLate(than: oneHour) {
            result = "\(component.minute!)分钟前"
        } else if date.isEarly(than: oneHour) && date.isLate(than: today) {
            result = "\(component.hour!)小时前"
        } else if date.isEarly(than: today) && date.isLate(than: yesterday) {
            result = "昨天"
        } else if date.isEarly(than: yesterday) && date.isLate(than: twoday) {
            result = "前天"
        } else {
            formatter.dateFormat = "MM-dd"
            result = formatter.string(from: date)
        }
        return result
    }
}

/// tb自定义 显示日期和时间
class TBDetailDateFormatter: TBBaseDateFormatter {

    /// - Note:
    /// 一分钟内显示一分钟内
    /// 一小时内显示几分钟前，
    /// 一天内显示几小时前，
    /// 1天到2天显示如（昨天 20:36），
    /// 2天到3天显示如（前天 20：34），
    /// 3天以上显示如（02-28 19:15）
    override func formatDate(_ date: Date, timeZone: TimeZone?) -> String {
        let now: Date = Date()
        let today = calendar.startOfDay(for: now)
        let oneMinute = calendar.date(byAdding: Calendar.Component.minute, value: -1, to: now, wrappingComponents: false)!
        let oneHour = calendar.date(byAdding: Calendar.Component.hour, value: -1, to: now, wrappingComponents: false)!
        let yesterday = calendar.date(byAdding: Calendar.Component.day, value: -1, to: today, wrappingComponents: false)!
        let twoday = calendar.date(byAdding: Calendar.Component.day, value: -2, to: today, wrappingComponents: false)!

        var result: String = ""
        let component = calendar.dateComponents([.day, .hour, .minute], from: date, to: now)
        formatter.timeZone = timeZone
        if date.isLate(than: oneMinute) {
            // 1min的判断不够严谨
            result = "1分钟内"
        } else if date.isEarly(than: oneMinute) && date.isLate(than: oneHour) {
            result = "\(component.minute!)分钟前"
        } else if date.isEarly(than: oneHour) && date.isLate(than: today) {
            result = "\(component.hour!)小时前"
        } else if date.isEarly(than: today) && date.isLate(than: yesterday) {
            formatter.dateFormat = "HH:mm"
            result = "昨天 \(formatter.string(from: date))"
        } else if date.isEarly(than: yesterday) && date.isLate(than: twoday) {
            formatter.dateFormat = "HH:mm"
            result = "前天 \(formatter.string(from: date))"
        } else {
            formatter.dateFormat = "MM-dd HH:mm"
            result = formatter.string(from: date)
        }
        return result
    }
}
